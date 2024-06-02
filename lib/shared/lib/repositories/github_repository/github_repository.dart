import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'response_models.dart';

abstract interface class IGithubRepository {
  Future<GenerateCodeResponse> generateDeviceCode();
  Future<GetAccessTokenResponse> getAccessToken(String deviceCode);
}

class GithubRepository implements IGithubRepository {
  final Dio _dio;

  GithubRepository() : _dio = Dio(BaseOptions(baseUrl: 'https://github.com'));

  Map<String, String> _parseResponse(String? response) {
    final entries = response?.split('&').map((e) {
      final parts = e.split('=');
      return MapEntry(parts[0], parts[1]);
    });
    return Map.fromEntries(entries ?? const Iterable.empty());
  }

  @override
  Future<GenerateCodeResponse> generateDeviceCode() async {
    final response = await _dio.post<String>(
      '/login/device/code',
      data: {
        'client_id': dotenv.env['GITHUB_CLIENT_ID'],
      },
    );

    return GenerateCodeResponse.fromMap(_parseResponse(response.data));
  }

  @override
  Future<GetAccessTokenResponse> getAccessToken(String deviceCode) async {
    try {
      final response = await _dio.post<String>(
        '/login/oauth/access_token',
        data: {
          'client_id': dotenv.env['GITHUB_CLIENT_ID'],
          'device_code': deviceCode,
          'grant_type': 'urn:ietf:params:oauth:grant-type:device_code',
        },
      );
      return GetAccessTokenResponse.fromMap(_parseResponse(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
