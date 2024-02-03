part of 'password_files_decrypted_cubit.dart';

class DecryptedPasswordFilesState extends Equatable {
  final List<PasswordFileModel> decryptedFiles;
  final PasswordFileModel? selectedFile;
  final String searchText;

  const DecryptedPasswordFilesState({
    required this.decryptedFiles,
    this.selectedFile,
    this.searchText = '',
  });

  DecryptedPasswordFilesState copyWith({
    List<PasswordFileModel>? decryptedFiles,
    PasswordFileModel? selectedFile,
    String? searchText,
  }) {
    return DecryptedPasswordFilesState(
      decryptedFiles: decryptedFiles ?? this.decryptedFiles,
      selectedFile: selectedFile ?? this.selectedFile,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [decryptedFiles, selectedFile, searchText];
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

class PasswordFilesSavingFailed extends DecryptedPasswordFilesState {
  final String message;

  const PasswordFilesSavingFailed({
    required super.decryptedFiles,
    required this.message,
    required super.selectedFile,
    required super.searchText,
  });

  @override
  get props => super.props..add(message);
}
