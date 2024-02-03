part of 'password_files_decrypted_cubit.dart';

class DecryptedPasswordFilesState extends Equatable {
  final List<PasswordFileModel> decryptedFiles;
  final PasswordFileModel? selectedFile;

  const DecryptedPasswordFilesState({
    required this.decryptedFiles,
    this.selectedFile,
  });

  @override
  List<Object?> get props => [decryptedFiles, selectedFile];
}

class PasswordFilesDecryptionFailed extends DecryptedPasswordFilesState {
  final String message;

  const PasswordFilesDecryptionFailed({
    required super.decryptedFiles,
    required this.message,
  });

  @override
  get props => super.props..add(message);
}
