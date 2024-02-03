import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/entities/config/_vm/models/config_model.dart';
import 'package:password_manager/shared/lib/configuration_file.dart';

part 'configuration_file_event.dart';
part 'configuration_file_state.dart';

class ConfigurationFileBloc
    extends Bloc<ConfigurationFileEvent, ConfigurationFileState> {
  late final IConfigurationFileReader _configurationFileReader;

  ConfigurationFileBloc({required IConfigurationFileReader configFileReader})
      : super(ConfigurationFileInitial()) {
    _configurationFileReader = configFileReader;
    on<ConfigurationFileInit>(_init);
    on<ConfigurationFileSelectFileOrDirectory>(_selectFileOrDirectory);
    on<ConfigurationFileReload>(_handleReload);
  }

  void _init(
    ConfigurationFileInit event,
    Emitter<ConfigurationFileState> emit,
  ) async {
    emit(const ConfigurationFileInitError('Error occured while initializing'));
    // try {
    //   // TODO: read path from secure storagex§
    //   const path = null;
    //   emit(ConfigurationFileLoading());
    //   const configReader = ConfigurationFileReader(path);
    //   final content = await configReader.readConfigContent();
    //   final configs = content.map(ConfigModel.fromMap).toList();
    //   emit(ConfigurationFileLoaded(configs: configs, path: path));
    // } catch (e) {
    //   emit(ConfigurationFileInitError(e.toString()));
    // }
  }

  void _selectFileOrDirectory(
    ConfigurationFileSelectFileOrDirectory event,
    Emitter<ConfigurationFileState> emit,
  ) async {
    try {
      emit(ConfigurationFileLoading());
      final file = await _configurationFileReader.getOrCreate(event.path);
      final content = await _configurationFileReader.read(event.path);
      final configs = content.map(ConfigModel.fromMap).toList();
      // TODO: save path to config file in secure storage
      emit(ConfigurationFileLoaded(configs: configs, path: file.path));
    } on TypeError catch (e) {
      log(e.toString());
      emit(const ConfigurationFileError('Invalid configuration file'));
    } on FormatException catch (e) {
      log(e.toString());
      emit(const ConfigurationFileError('Invalid configuration file'));
    } on PathNotFoundException catch (e) {
      log(e.toString());
      emit(const ConfigurationFileError(
        'Invalid path to configuration file. Please check your path',
      ));
    } on PathAccessException catch (e) {
      log(e.toString());
      emit(const ConfigurationFileError(
        'Something with permissions to this file or directory. Please check it',
      ));
    } on FileSystemException catch (e) {
      log(e.toString());
      emit(const ConfigurationFileError(
        'Invalid path to configuration file. Please check your path',
      ));
    } on Exception catch (e) {
      log(e.toString());
      emit(ConfigurationFileError(e.toString()));
    }
  }

  void _handleReload(
    ConfigurationFileReload _,
    Emitter<ConfigurationFileState> emit,
  ) async {
    try {
      if (state is! ConfigurationFileLoaded) return;
      final loadedState = state as ConfigurationFileLoaded;

      emit(ConfigurationFileLoading());
      final content = await _configurationFileReader.read(loadedState.path);
      final configs = content.map(ConfigModel.fromMap).toList();
      log('configs: ${configs.toString()}');
      emit(ConfigurationFileLoaded(configs: configs, path: loadedState.path));
    } catch (e) {
      log(e.toString());
      emit(ConfigurationFileError(e.toString()));
    }
  }
}
