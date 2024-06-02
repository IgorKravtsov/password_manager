import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/shared/lib/database.dart';

import 'package:password_manager/shared/lib/repositories/github_repository/github_repository.dart';
import 'package:password_manager/shared/lib/repositories/github_repository/response_models.dart';

part 'connect_github_event.dart';
part 'connect_github_state.dart';

class ConnectGithubBloc extends Bloc<ConnectGithubEvent, ConnectGithubState> {
  late final IGithubRepository _githubRepository;
  late final IDatabase _database;

  ConnectGithubBloc({
    required IGithubRepository githubRepository,
    required IDatabase database,
  }) : super(ConnectGithubInitial()) {
    _githubRepository = githubRepository;
    _database = database;

    on<ConnectGithubGenerateDeviceCode>(_generateDeviceCode);
  }

  void _generateDeviceCode(
    ConnectGithubGenerateDeviceCode event,
    Emitter<ConnectGithubState> emit,
  ) async {
    emit(ConnectGithubLoading());
    try {
      final response = await _githubRepository.generateDeviceCode();
      emit(ConnectGithubDeviceCodeGenerated(generateCodeResponse: response));
      Timer.periodic(Duration(seconds: response.interval + 2), (timer) async {
        final tokenResponse =
            await _githubRepository.getAccessToken(response.deviceCode);
        if (tokenResponse.error?.contains('authorization_pending') == true) {
          return;
        }

        if (tokenResponse.error != null) {
          emit(ConnectGithubAccessTokenError(
              message: tokenResponse.error ?? 'An error occurred'));
          timer.cancel();
          return;
        }

        final currDate = DateTime.now();
        await Future.wait([
          _database.save('githubAccessToken', tokenResponse.accessToken),
          _database.save('githubRefreshToken', tokenResponse.refreshToken),
          _database.save(
            'githubAccessTokenExpires',
            currDate
                .add(Duration(seconds: tokenResponse.expiresIn ?? 0))
                .toIso8601String(),
          ),
          _database.save(
            'githubRefreshTokenExpires',
            currDate
                .add(
                  Duration(seconds: tokenResponse.refreshTokenExpiresIn ?? 0),
                )
                .toIso8601String(),
          ),
        ]);

        emit(ConnectGithubAccessTokenReceived(
          getAccessTokenResponse: tokenResponse,
        ));
        timer.cancel();
      });
    } catch (e) {
      emit(ConnectGithubError(message: e.toString()));
    }
  }
}
