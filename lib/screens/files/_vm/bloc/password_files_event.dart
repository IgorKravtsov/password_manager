part of 'password_files_bloc.dart';

sealed class PasswordFilesEvent extends Equatable {
  const PasswordFilesEvent();

  @override
  List<Object?> get props => [];
}

final class PasswordFilesLoad extends PasswordFilesEvent {
  final List<ConfigModel> configs;
  const PasswordFilesLoad(this.configs);

  @override
  List<Object?> get props => super.props..add(configs);
}

final class PasswordFilesAdd extends PasswordFilesEvent {
  final String pathToFile;
  final String secretKey;

  const PasswordFilesAdd({required this.pathToFile, required this.secretKey});

  @override
  List<Object?> get props => super.props..addAll([pathToFile, secretKey]);
}

final class PasswordFilesRemove extends PasswordFilesEvent {
  final int index;
  final String pathToConfigFile;
  final Completer<void>? completer;

  const PasswordFilesRemove({
    required this.index,
    required this.pathToConfigFile,
    this.completer,
  });

  @override
  List<Object?> get props => super.props..addAll([index]);
}

final class PasswordFilesSave extends PasswordFilesEvent {
  final String pathToConfigFile;
  final ConfigModel config;
  final int index;
  final Completer<void>? completer;

  const PasswordFilesSave({
    required this.pathToConfigFile,
    required this.config,
    required this.index,
    this.completer,
  });

  @override
  List<Object?> get props => super.props..addAll([config, index, completer]);
}
