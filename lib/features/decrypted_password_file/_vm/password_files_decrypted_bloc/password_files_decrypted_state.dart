part of 'password_files_decrypted_bloc.dart';

sealed class PasswordFilesDecryptedState extends Equatable {
  final List<ConfigModel> configs;
  const PasswordFilesDecryptedState({this.configs = const []});

  @override
  List<Object> get props => [];
}

final class PasswordFilesDecryptedInitial extends PasswordFilesDecryptedState {
  const PasswordFilesDecryptedInitial();
}

final class PasswordFilesDecryptedLoaded extends PasswordFilesDecryptedState {
  const PasswordFilesDecryptedLoaded(List<ConfigModel> configs)
      : super(configs: configs);
}

final class PasswordFilesDecrptionFinished extends PasswordFilesDecryptedState {
  final List<PasswordFileModel> decryptedFiles;

  const PasswordFilesDecrptionFinished({
    required super.configs,
    required this.decryptedFiles,
  });

  @override
  List<Object> get props => super.props..add(decryptedFiles);
}

final class PasswordFilesDecryptionFailed extends PasswordFilesDecryptedState {
  final String message;

  const PasswordFilesDecryptionFailed({
    required super.configs,
    required this.message,
  });

  @override
  List<Object> get props => super.props..add(message);
}
