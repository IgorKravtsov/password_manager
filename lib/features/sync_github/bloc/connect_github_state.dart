part of 'connect_github_bloc.dart';

sealed class ConnectGithubState extends Equatable {
  const ConnectGithubState();

  @override
  List<Object> get props => [];
}

final class ConnectGithubInitial extends ConnectGithubState {}

final class ConnectGithubLoading extends ConnectGithubState {}

final class ConnectGithubError extends ConnectGithubState {
  final String message;

  const ConnectGithubError({this.message = 'An error occurred'});

  @override
  List<Object> get props => super.props..addAll([message]);
}

final class ConnectGithubDeviceCodeGenerated extends ConnectGithubState {
  final GenerateCodeResponse generateCodeResponse;

  const ConnectGithubDeviceCodeGenerated({required this.generateCodeResponse});

  @override
  List<Object> get props => super.props..addAll([generateCodeResponse]);
}

final class ConnectGithubAccessTokenError extends ConnectGithubState {
  final String message;

  const ConnectGithubAccessTokenError({this.message = 'An error occurred'});

  @override
  List<Object> get props => super.props..addAll([message]);
}

final class ConnectGithubAccessTokenReceived extends ConnectGithubState {
  final GetAccessTokenResponse getAccessTokenResponse;

  const ConnectGithubAccessTokenReceived({
    required this.getAccessTokenResponse,
  });

  @override
  List<Object> get props => super.props..addAll([getAccessTokenResponse]);
}
