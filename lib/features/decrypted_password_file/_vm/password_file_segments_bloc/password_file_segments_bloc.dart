import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

part 'password_file_segments_event.dart';
part 'password_file_segments_state.dart';

class PasswordFileSegmentsBloc
    extends Bloc<PasswordFileSegmentsEvent, PasswordFileSegmentsState> {
  late final IPasswordFileEncrypter _passwordFileEncrypter;

  PasswordFileSegmentsBloc({
    required IPasswordFileEncrypter encrypter,
    required PasswordFileModel passwordFile,
  }) : super(PasswordFileSegmentsInitial(passwordFile)) {
    _passwordFileEncrypter = encrypter;
    on<PasswordFileSegmentSave>(_handleSegmentSave);
    on<PasswordFileSegmentDelete>(_handleSegmentDelete);
    on<PasswordFileSegmentAdd>(_handleSegmentAdd);
  }

  void _handleSegmentSave(
    PasswordFileSegmentSave event,
    Emitter<PasswordFileSegmentsState> emit,
  ) async {
    final segments = state.passwordFile.segments;
    final newSegments = [
      ...segments.sublist(0, event.segmentIndex),
      PasswordFileSegmentModel(
        title: event.title,
        content: event.content,
      ),
      ...segments.sublist(event.segmentIndex + 1),
    ];

    try {
      final file = File(state.passwordFile.pathToFile);
      final encryptedContent = await _passwordFileEncrypter.encryptSegments(
        newSegments,
        state.passwordFile.secretKey,
      );
      await file.writeAsString(encryptedContent);
      emit(PasswordFileSegmentsLoaded(
        passwordFile: state.passwordFile.copyWith(segments: newSegments),
      ));
    } catch (e) {
      log('error: $e');
      emit(PasswordFileSegmentsError(
        passwordFile: state.passwordFile,
        message: e.toString(),
      ));
    }
  }

  void _handleSegmentDelete(
    PasswordFileSegmentDelete event,
    Emitter<PasswordFileSegmentsState> emit,
  ) async {
    final segments = state.passwordFile.segments;
    final newSegments = [
      ...segments.sublist(0, event.segmentIndex),
      ...segments.sublist(event.segmentIndex + 1),
    ];

    try {
      final file = File(state.passwordFile.pathToFile);
      final encryptedContent = await _passwordFileEncrypter.encryptSegments(
        newSegments,
        state.passwordFile.secretKey,
      );
      await file.writeAsString(encryptedContent);
      emit(PasswordFileSegmentsLoaded(
        passwordFile: state.passwordFile.copyWith(segments: newSegments),
      ));
    } catch (e) {
      log('error: $e');
      emit(PasswordFileSegmentsError(
        passwordFile: state.passwordFile,
        message: e.toString(),
      ));
    }
  }

  void _handleSegmentAdd(
    PasswordFileSegmentAdd event,
    Emitter<PasswordFileSegmentsState> emit,
  ) async {
    final segments = state.passwordFile.segments;
    final newSegments = [
      ...segments,
      PasswordFileSegmentModel(
        title: event.title,
        content: event.content,
      ),
    ];

    try {
      //TODO: delete try catch
      // final file = File(state.passwordFile.pathToFile);
      // final encryptedContent = await _passwordFileEncrypter.encryptSegments(
      //   newSegments,
      //   state.passwordFile.secretKey,
      // );
      // await file.writeAsString(encryptedContent);
      emit(PasswordFileSegmentsLoaded(
        passwordFile: state.passwordFile.copyWith(segments: newSegments),
      ));
    } catch (e) {
      log('error: $e');
      emit(PasswordFileSegmentsError(
        passwordFile: state.passwordFile,
        message: e.toString(),
      ));
    }
  }
}
