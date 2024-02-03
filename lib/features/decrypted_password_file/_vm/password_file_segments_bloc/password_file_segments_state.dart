part of 'password_file_segments_bloc.dart';

sealed class PasswordFileSegmentsState extends Equatable {
  final PasswordFileModel passwordFile;
  const PasswordFileSegmentsState({required this.passwordFile});

  @override
  List<Object> get props => [];
}

final class PasswordFileSegmentsInitial extends PasswordFileSegmentsState {
  const PasswordFileSegmentsInitial(PasswordFileModel passwordFile)
      : super(passwordFile: passwordFile);
}

final class PasswordFileSegmentsLoaded extends PasswordFileSegmentsState {
  const PasswordFileSegmentsLoaded({required PasswordFileModel passwordFile})
      : super(passwordFile: passwordFile);
}

final class PasswordFileSegmentsError extends PasswordFileSegmentsState {
  final String message;
  const PasswordFileSegmentsError({
    required PasswordFileModel passwordFile,
    required this.message,
  }) : super(passwordFile: passwordFile);

  @override
  List<Object> get props => super.props..add(message);
}
