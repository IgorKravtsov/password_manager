// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GenerateCodeResponse extends Equatable {
  final String deviceCode;
  final String userCode;
  final String verificationUri;
  final int expiresIn;
  final int interval;

  const GenerateCodeResponse({
    required this.deviceCode,
    required this.userCode,
    required this.verificationUri,
    required this.expiresIn,
    required this.interval,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceCode': deviceCode,
      'userCode': userCode,
      'verificationUri': verificationUri,
      'expiresIn': expiresIn,
      'interval': interval,
    };
  }

  factory GenerateCodeResponse.fromMap(Map<String, dynamic> map) {
    return GenerateCodeResponse(
      deviceCode: map['device_code'] as String,
      userCode: map['user_code'] as String,
      verificationUri: Uri.decodeFull(map['verification_uri']),
      expiresIn: int.parse(map['expires_in']),
      interval: int.parse(map['interval']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerateCodeResponse.fromJson(String source) =>
      GenerateCodeResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props =>
      [deviceCode, userCode, verificationUri, expiresIn, interval];
}

class GetAccessTokenResponse extends Equatable {
  final String? error;
  final String? accessToken;
  final String? tokenType;
  final String? refreshToken;
  final int? expiresIn;
  final int? refreshTokenExpiresIn;
  final String? scope;

  const GetAccessTokenResponse({
    this.error,
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.refreshTokenExpiresIn,
    this.scope,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'access_token': accessToken,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'refresh_token_expires_in': refreshTokenExpiresIn,
      'scope': scope,
    };
  }

  factory GetAccessTokenResponse.fromMap(Map<String, dynamic> map) {
    return GetAccessTokenResponse(
      error: map['error'] as String?,
      accessToken: map['access_token'] as String?,
      tokenType: map['token_type'] as String?,
      refreshToken: map['refresh_token'] as String?,
      expiresIn: int.tryParse(map['expires_in'] ?? ''),
      refreshTokenExpiresIn:
          int.tryParse(map['refresh_token_expires_in'] ?? ''),
      scope: map['scope'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAccessTokenResponse.fromJson(String source) =>
      GetAccessTokenResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [accessToken, tokenType];
}
