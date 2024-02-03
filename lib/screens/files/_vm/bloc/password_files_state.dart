part of 'password_files_bloc.dart';

sealed class PasswordFilesState extends Equatable {
  final List<ConfigModel> configs;
  const PasswordFilesState(this.configs);

  @override
  List<Object> get props => [configs];
}

final class PasswordFilesInitial extends PasswordFilesState {
  PasswordFilesInitial() : super([]);
}

final class PasswordFilesLoaded extends PasswordFilesState {
  const PasswordFilesLoaded(super.configs);
}

final class PasswordFilesError extends PasswordFilesState {
  final String message;

  const PasswordFilesError(super.configs, this.message);

  @override
  List<Object> get props => super.props..add(message);
}
