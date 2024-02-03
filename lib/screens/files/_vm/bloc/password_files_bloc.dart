import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/shared/lib/configuration_file_reader.dart';

import 'package:uuid/uuid.dart';

part 'password_files_event.dart';
part 'password_files_state.dart';

class PasswordFilesBloc extends Bloc<PasswordFilesEvent, PasswordFilesState> {
  late final IConfigurationFileReader _configurationFileReader;

  PasswordFilesBloc({required IConfigurationFileReader configFileReader})
      : super(PasswordFilesInitial()) {
    _configurationFileReader = configFileReader;

    on<PasswordFilesLoad>(_handleLoaded);
    on<PasswordFilesAdd>(_handleAdd);
    on<PasswordFilesRemove>(_removeFromList);
    on<PasswordFilesSave>(_handleSave);
  }

  void _handleLoaded(
    PasswordFilesLoad event,
    Emitter<PasswordFilesState> emit,
  ) {
    emit(PasswordFilesLoaded(event.configs));
  }

  void _handleAdd(PasswordFilesAdd event, Emitter<PasswordFilesState> emit) {
    emit(PasswordFilesLoaded(
      List.from(state.configs)
        ..add(ConfigModel(
          id: const Uuid().v4(),
          pathToFile: event.pathToFile,
          secretKey: event.secretKey,
        )),
    ));
  }

  void _removeFromList(
    PasswordFilesRemove event,
    Emitter<PasswordFilesState> emit,
  ) async {
    try {
      final List<ConfigModel> configs = List.from(state.configs)
        ..removeAt(event.index);

      await _configurationFileReader.save(
        event.pathToConfigFile,
        configs.map((config) => config.toMap()).toList(),
      );
      emit(PasswordFilesLoaded(configs));
    } catch (e) {
      log(e.toString());
      emit(PasswordFilesError(state.configs, 'Error removing file'));
      return;
    } finally {
      event.completer?.complete();
    }
  }

  void _handleSave(
    PasswordFilesSave event,
    Emitter<PasswordFilesState> emit,
  ) async {
    try {
      final List<ConfigModel> configs = List.from(state.configs);
      configs[event.index] = event.config;
      await _configurationFileReader.save(
        event.pathToConfigFile,
        configs.map((config) => config.toMap()).toList(),
      );
      emit(PasswordFilesLoaded(configs));
    } catch (e) {
      log(e.toString());
      emit(PasswordFilesError(state.configs, 'Error saving file'));
    } finally {
      event.completer?.complete();
    }
  }
}
