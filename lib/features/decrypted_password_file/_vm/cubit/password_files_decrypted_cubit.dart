import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/shared/lib/database.dart';

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
  late final IDecryptedPasswordFileSaver _decryptedPasswordFileSaver;
  late final IDatabase _database;

  PasswordFilesDecryptedCubit(
      {required IPasswordFileEncrypter encrypter,
      required IDecryptedPasswordFileSaver decryptedPasswordFileSaver,
      required IDatabase database})
      : super(const DecryptedPasswordFilesState(decryptedFiles: [])) {
    _passwordFileEncrypter = encrypter;
    _decryptedPasswordFileSaver = decryptedPasswordFileSaver;
    _database = database;
  }

  void decryptPasswordFiles(List<ConfigModel> configs) async {
    if (configs.isEmpty) return;

      final List<PasswordFileModel> decryptedFiles = [];
    // try {
    for (var config in configs) {
      try {
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
        ));
      } catch (e) {
        log('error: $e');
        decryptedFiles.add(PasswordFileModel(
          secretKey: config.secretKey,
          pathToFile: config.pathToFile,
          segments: const [],
          isError: true,
          errorMessage: e.toString(),
        ));
        // emit(
        //   PasswordFilesDecryptionFailed(
        //     decryptedFiles: decryptedFiles,
        //     message: e.toString(),
        //   ),
        // );
      }
        
    }
    emit(DecryptedPasswordFilesState(
      decryptedFiles: decryptedFiles,
      selectedFile: decryptedFiles.first,
    ));
    // } catch (e) {
    //   log('error: $e');
    //   emit(
    //     PasswordFilesDecryptionFailed(
    //       decryptedFiles: decryptedFiles,
    //       message: e.toString(),
    //     ),
    //   );
    // }
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
      emit(state.copyWith(decryptedFiles: decryptedFiles));
    } catch (e) {
      emit(
        PasswordFilesDecryptionFailed(
            decryptedFiles: state.decryptedFiles, message: e.toString()),
      );
    } finally {
      completer?.complete();
    }
  }

  void selectFile(PasswordFileModel file) async {
      emit(state.copyWith(selectedFile: file));
    await _database.saveLastSelectedFilePath(file.pathToFile);
  }

  Future<void> _saveToFile(PasswordFileModel passwordFile) async {
    try {
      final file = File(passwordFile.pathToFile);
      String content = '';
      if (passwordFile.segments.isNotEmpty) {
        content = await _passwordFileEncrypter.encryptSegments(
          passwordFile.segments,
          passwordFile.secretKey,
        );
      }
      await file.writeAsString(content);

      void saveCopy() {
        final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final path = file.path.replaceFirst('.txt', '_$date.txt');
        final fileCopy = File('${path}_copy');
        fileCopy.writeAsString(content);
      }

      saveCopy();
    } catch (e) {
      log('error: $e');
      rethrow;
    }
    
  }

  void saveSearch(String text) {
    emit(state.copyWith(searchText: text));
  }

  void exportDecryptedFile(String path) async {
    if (state.selectedFile == null) return;

    final filePath = '$path/${state.selectedFile!.fileName}';

    try {
      await _decryptedPasswordFileSaver.save(
          filePath, state.selectedFile!.segments);
    } catch (e) {
      log('error: $e');
      emit(
        PasswordFilesSavingFailed(
          message: e.toString(),
          decryptedFiles: state.decryptedFiles,
          selectedFile: state.selectedFile,
          searchText: state.searchText,
        ),
      );
    }
  }

  void reorderSegments(int oldIndex, int newIndex) async {
    final selectedFile = state.selectedFile;
    if (selectedFile == null) return;

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    try {
      final segments =
          List<PasswordFileSegmentModel>.from(selectedFile.segments);
      final segment = segments.removeAt(oldIndex);
      segments.insert(newIndex, segment);
      final newSelectedFile = selectedFile.copyWith(segments: segments);

      final decryptedFiles = state.decryptedFiles;
      final decryptedFilesIndex =
          decryptedFiles.indexWhere((element) => element == selectedFile);
      decryptedFiles[decryptedFilesIndex] = newSelectedFile;

      await _saveToFile(newSelectedFile);
      emit(state.copyWith(
        decryptedFiles: decryptedFiles,
        selectedFile: newSelectedFile,
      ));
    } catch (e) {
      print(e);
      emit(
        PasswordFilesSavingFailed(
          message: e.toString(),
          decryptedFiles: state.decryptedFiles,
          selectedFile: state.selectedFile,
          searchText: state.searchText,
        ),
      );
    }

    // try {
    // } catch (e) {
    //   print(e);
    //   emit(
    //     PasswordFilesSavingFailed(
    //       message: e.toString(),
    //       decryptedFiles: state.decryptedFiles,
    //       selectedFile: state.selectedFile,
    //       searchText: state.searchText,
    //     ),
    //   );
    // }
    
  }
}
