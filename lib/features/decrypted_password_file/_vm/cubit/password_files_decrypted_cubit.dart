import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

part 'password_files_decrypted_state.dart';

final List<PasswordFileSegmentModel> FAKE_SEGMENTS = [
  const PasswordFileSegmentModel(
      title: 'Facebook',
      content: 'Email: test.email@gmail.com\nPassword: 123456'),
  const PasswordFileSegmentModel(
      title: 'Gmail', content: 'Email: test.email@gmail.com\nPassword: 123456'),
  const PasswordFileSegmentModel(
      title: 'Instagram',
      content: 'Email: test.email@gmail.com\nPassword: 123456'),
];

class PasswordFilesDecryptedCubit extends Cubit<DecryptedPasswordFilesState> {
  late final IPasswordFileEncrypter _passwordFileEncrypter;

  PasswordFilesDecryptedCubit({required IPasswordFileEncrypter encrypter})
      : super(const DecryptedPasswordFilesState(decryptedFiles: [])) {
    _passwordFileEncrypter = encrypter;
  }

  void decryptPasswordFiles(List<ConfigModel> configs) async {
    if (configs.isEmpty) return;

    try {
      final List<PasswordFileModel> decryptedFiles = [];
      for (var config in configs) {
        final file = File(config.pathToFile);
        final bytes = await file.readAsBytes();
        final ecryptedContent = String.fromCharCodes(bytes);
        final segments = await _passwordFileEncrypter.decryptSegments(
          ecryptedContent,
          config.secretKey,
        );
        decryptedFiles.add(PasswordFileModel(
          secretKey: config.secretKey,
          pathToFile: config.pathToFile,
          segments: segments,
          // segments: FAKE_SEGMENTS,
        ));
      }
      emit(DecryptedPasswordFilesState(decryptedFiles: decryptedFiles));
    } catch (e) {
      log('error: $e');
      emit(
        PasswordFilesDecryptionFailed(
            decryptedFiles: const [], message: e.toString()),
      );
    }
  }

  Future<void> saveSegments({
    required PasswordFileModel passwordFile,
    required List<PasswordFileSegmentModel> segments,
    Completer<void>? completer,
  }) async {
    final decryptedFiles = state.decryptedFiles;
    final index =
        decryptedFiles.indexWhere((element) => element == passwordFile);

    if (index == -1) return;

    try {
      final updatedPasswordFile = passwordFile.copyWith(segments: segments);
      await _saveToFile(updatedPasswordFile);
      decryptedFiles[index] = updatedPasswordFile;
      emit(DecryptedPasswordFilesState(decryptedFiles: decryptedFiles));
    } catch (e) {
      emit(
        PasswordFilesDecryptionFailed(
            decryptedFiles: state.decryptedFiles, message: e.toString()),
      );
    } finally {
      completer?.complete();
    }
  }

  void selectFile(PasswordFileModel? file) => emit(DecryptedPasswordFilesState(
      decryptedFiles: state.decryptedFiles, selectedFile: file));

  Future<void> _saveToFile(PasswordFileModel passwordFile) async {
    final file = File(passwordFile.pathToFile);
    final encryptedContent = await _passwordFileEncrypter.encryptSegments(
      passwordFile.segments,
      passwordFile.secretKey,
    );
    await file.writeAsString(encryptedContent);
  }
}
