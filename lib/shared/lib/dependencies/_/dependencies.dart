import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:password_manager/shared/lib/database.dart';
import 'package:password_manager/shared/lib/configuration_file_reader.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

import '../inherited_dependencies.dart';

/// Dependencies
abstract interface class Dependencies {
  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) =>
      InheritedDependencies.of(context);

  /// Encryption algorithm
  abstract final IContentEncrypter contentEncrypter;

  abstract final IPasswordFileEncrypter passwordFileEncrypter;

  abstract final IDecryptedPasswordFileSaver decryptedPasswordFileSaver;

  abstract final IConfigurationFileReader configurationFileReader;

  abstract final Talker talker;

  abstract final IDatabase database;

  // /// App metadata
  // abstract final AppMetadata appMetadata;

  // /// Database
  // abstract final Database database;

  // /// Authentication controller
  // abstract final AuthenticationController authenticationController;

  // /// Settings controller
  // abstract final SettingsController settingsController;

  // /// Cloud repository
  // abstract final IMyRepository myRepository;
}

final class $MutableDependencies implements Dependencies {
  $MutableDependencies() : context = <String, Object?>{};

  /// Initialization context
  final Map<Object?, Object?> context;

  // @override
  // late AppMetadata appMetadata;

  // @override
  // late Database database;

  // @override
  // late AuthenticationController authenticationController;

  // @override
  // late SettingsController settingsController;

  // @override
  // late IMyRepository myRepository;

  Dependencies freeze() => _$ImmutableDependencies(
        configurationFileReader: configurationFileReader,
        contentEncrypter: contentEncrypter,
        database: database,
        decryptedPasswordFileSaver: decryptedPasswordFileSaver,
        passwordFileEncrypter: passwordFileEncrypter,
        talker: talker,
      );

  @override
  late IConfigurationFileReader configurationFileReader;

  @override
  late IContentEncrypter contentEncrypter;

  @override
  late IDatabase database;

  @override
  late IDecryptedPasswordFileSaver decryptedPasswordFileSaver;

  @override
  late IPasswordFileEncrypter passwordFileEncrypter;

  @override
  late Talker talker;
}

final class _$ImmutableDependencies implements Dependencies {
  _$ImmutableDependencies({
    required this.decryptedPasswordFileSaver,
    required this.configurationFileReader,
    required this.contentEncrypter,
    required this.database,
    required this.passwordFileEncrypter,
    required this.talker,
  });

  @override
  final IConfigurationFileReader configurationFileReader;

  @override
  final IContentEncrypter contentEncrypter;

  @override
  final IDatabase database;

  @override
  final IDecryptedPasswordFileSaver decryptedPasswordFileSaver;

  @override
  final IPasswordFileEncrypter passwordFileEncrypter;

  @override
  final Talker talker;
}
