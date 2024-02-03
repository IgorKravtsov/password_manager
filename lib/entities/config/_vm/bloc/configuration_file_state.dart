part of 'configuration_file_bloc.dart';

sealed class ConfigurationFileState extends Equatable {
  final List<ConfigModel> configs;
  const ConfigurationFileState({this.configs = const []});

  @override
  List<Object?> get props => [];
}

final class ConfigurationFileInitial extends ConfigurationFileState {}

class ConfigurationFileLoading extends ConfigurationFileState {}

class ConfigurationFileLoaded extends ConfigurationFileState {
  final String path;

  const ConfigurationFileLoaded({super.configs, required this.path});

  @override
  get props => [configs, path];
}

class ConfigurationFileInitError extends ConfigurationFileState {
  final String message;

  const ConfigurationFileInitError(this.message);

  @override
  get props => [message];
}

class ConfigurationFileError extends ConfigurationFileState {
  final String message;

  const ConfigurationFileError(this.message);

  @override
  get props => [message];
}
