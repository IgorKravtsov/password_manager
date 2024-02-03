part of 'configuration_file_bloc.dart';

sealed class ConfigurationFileEvent extends Equatable {
  const ConfigurationFileEvent();

  @override
  List<Object?> get props => [];
}

class ConfigurationFileInit extends ConfigurationFileEvent {}

class ConfigurationFileSelectFileOrDirectory extends ConfigurationFileEvent {
  final String? path;

  const ConfigurationFileSelectFileOrDirectory(this.path);

  @override
  get props => [path];
}

class ConfigurationFileReload extends ConfigurationFileEvent {}
