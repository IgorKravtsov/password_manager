part of 'connect_github_bloc.dart';

sealed class ConnectGithubEvent extends Equatable {
  const ConnectGithubEvent();

  @override
  List<Object> get props => [];
}

final class ConnectGithubGenerateDeviceCode extends ConnectGithubEvent {
  const ConnectGithubGenerateDeviceCode();
}

final class ConnectGithubGetAccessToken extends ConnectGithubEvent {
  final String deviceCode;

  const ConnectGithubGetAccessToken({required this.deviceCode});

  @override
  List<Object> get props => [deviceCode];
}
