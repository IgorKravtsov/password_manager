import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

part 'password_files_decrypted_event.dart';
part 'password_files_decrypted_state.dart';

class PasswordFilesDecryptedBloc
    extends Bloc<PasswordFilesDecryptedEvent, PasswordFilesDecryptedState> {
  late final IPasswordFileEncrypter _passwordFileEncrypter;

  PasswordFilesDecryptedBloc({required IPasswordFileEncrypter encrypter})
      : super(const PasswordFilesDecryptedInitial()) {
    _passwordFileEncrypter = encrypter;
    on<PasswordFilesDecryptedLoad>(_handleLoad);
    on<PasswordFilesDecryptInitiated>(_handleDecryptInitiated);
    // on<PasswordFilesSaveSegment>(_handleSaveSegment);
  }

  void _handleLoad(
    PasswordFilesDecryptedLoad event,
    Emitter<PasswordFilesDecryptedState> emit,
  ) {
    emit(PasswordFilesDecryptedLoaded(event.configs));
  }

  void _handleDecryptInitiated(
    PasswordFilesDecryptInitiated event,
    Emitter<PasswordFilesDecryptedState> emit,
  ) async {
    if (state is! PasswordFilesDecryptedLoaded) return;
    final configs = (state as PasswordFilesDecryptedLoaded).configs;
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
        ));
      }
      emit(PasswordFilesDecrptionFinished(
        configs: configs,
        decryptedFiles: decryptedFiles,
      ));
    } catch (e) {
      log('error: $e');
      emit(
        PasswordFilesDecryptionFailed(configs: configs, message: e.toString()),
      );
    }
  }

  // void _handleSaveSegment(
  //   PasswordFilesSaveSegment event,
  //   Emitter<PasswordFilesDecryptedState> emit,
  // ) {
  //   if (state is! PasswordFilesDecrptionFinished) return;
  //   final decryptedFilesState = state as PasswordFilesDecrptionFinished;

  //   // event.
  // }
}
