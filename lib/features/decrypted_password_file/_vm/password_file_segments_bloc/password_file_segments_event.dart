part of 'password_file_segments_bloc.dart';

sealed class PasswordFileSegmentsEvent extends Equatable {
  final PasswordFileModel passwordFile;
  const PasswordFileSegmentsEvent({required this.passwordFile});

  @override
  List<Object> get props => [passwordFile];
}

class PasswordFileSegmentSave extends PasswordFileSegmentsEvent {
  final int segmentIndex;
  final String title;
  final String content;

  const PasswordFileSegmentSave({
    required PasswordFileModel passwordFile,
    required this.segmentIndex,
    required this.title,
    required this.content,
  }) : super(passwordFile: passwordFile);

  @override
  List<Object> get props => super.props..addAll([segmentIndex, title, content]);
}

class PasswordFileSegmentDelete extends PasswordFileSegmentsEvent {
  final int segmentIndex;

  const PasswordFileSegmentDelete({
    required PasswordFileModel passwordFile,
    required this.segmentIndex,
  }) : super(passwordFile: passwordFile);

  @override
  List<Object> get props => super.props..add(segmentIndex);
}

class PasswordFileSegmentAdd extends PasswordFileSegmentsEvent {
  final String title;
  final String content;

  const PasswordFileSegmentAdd({
    required PasswordFileModel passwordFile,
    required this.title,
    required this.content,
  }) : super(passwordFile: passwordFile);

  @override
  List<Object> get props => super.props..addAll([title, content]);
}
