part of 'password_files_decrypted_bloc.dart';

sealed class PasswordFilesDecryptedEvent extends Equatable {
  const PasswordFilesDecryptedEvent();

  @override
  List<Object> get props => [];
}

final class PasswordFilesDecryptedLoad extends PasswordFilesDecryptedEvent {
  final List<ConfigModel> configs;
  const PasswordFilesDecryptedLoad(this.configs);

  @override
  List<Object> get props => super.props..add(configs);
}

final class PasswordFilesDecryptInitiated extends PasswordFilesDecryptedEvent {}

// final class PasswordFilesSaveSegment extends PasswordFilesDecryptedEvent {
//   final PasswordFileSegmentModel segment;
//   final int segmentIndex;
//   final PasswordFileModel passwordFileModel;

//   const PasswordFilesSaveSegment({
//     required this.segment,
//     required this.segmentIndex,
//     required this.passwordFileModel,
//   });

//   @override
//   List<Object> get props => super.props..add(segment);
// }
