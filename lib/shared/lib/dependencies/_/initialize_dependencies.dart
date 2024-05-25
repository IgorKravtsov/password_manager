import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/shared/lib/configuration_file_reader.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';
import 'package:password_manager/shared/lib/database.dart';

import 'dependencies.dart';

/// Initializes the app and returns a [Dependencies] object
Future<Dependencies> $initializeDependencies({
  void Function(int progress, String message)? onProgress,
}) async {
  final dependencies = $MutableDependencies();
  final totalSteps = _initializationSteps.length;
  var currentStep = 0;
  for (final step in _initializationSteps.entries) {
    currentStep++;
    final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
    onProgress?.call(percent, step.key);
    // l.v6(
    print(
        'Initialization | $currentStep/$totalSteps ($percent%) | "${step.key}"');
    await step.value(dependencies);
  }
  return dependencies.freeze();
}

typedef _InitializationStep = FutureOr<void> Function(
    $MutableDependencies dependencies);
final Map<String, _InitializationStep> _initializationSteps =
    <String, _InitializationStep>{
  // 'Platform pre-initialization': (_) => $platformInitialization(),
  // 'Creating app metadata': (dependencies) =>
  //     dependencies.appMetadata = AppMetadata(
  //       isWeb: platform.isWeb,
  //       isRelease: platform.buildMode.isRelease,
  //       appName: pubspec.name,
  //       appVersion: pubspec.version,
  //       appVersionMajor: pubspec.major,
  //       appVersionMinor: pubspec.minor,
  //       appVersionPatch: pubspec.patch,
  //       appBuildTimestamp: pubspec.build.isNotEmpty
  //           ? (int.tryParse(pubspec.build.firstOrNull ?? '-1') ?? -1)
  //           : -1,
  //       operatingSystem: platform.operatingSystem.name,
  //       processorsCount: platform.numberOfProcessors,
  //       appLaunchedTimestamp: DateTime.now(),
  //       locale: platform.locale,
  //       deviceVersion: platform.version,
  //       deviceScreenSize: ScreenUtil.screenSize().representation,
  //     ),
  // 'Observer state managment': (_) => Controller.observer = ControllerObserver(),
  'Initializing analytics': (_) async {/* ... */},
  'Log app open': (_) {},
  'Get remote config': (_) async {/* ... */},
  // 'Preparing secure storage': (dependencies) =>
  //     dependencies.context['SECURE_STORAGE'] = const fss.FlutterSecureStorage(),
  'Initializing the database': (dependencies) async {
    final db = HiveDatabase();
    await db.init();
    dependencies.database = db;
  },
  'Initializing file saver': (dependencies) => dependencies
      .decryptedPasswordFileSaver = const DecryptedPasswordFileSaver(),
  'Initializing Talker': (dependencies) =>
      dependencies.talker = TalkerFlutter.init(),
  'Initializing configuration file reader': (dependencies) async {
    dependencies.configurationFileReader = const ConfigurationFileReader();
    // await Future.delayed(const Duration(seconds: 2));
  },
  'Initializing content encrypter': (dependencies) =>
      dependencies.contentEncrypter = AESEncrypter(),
  'Initializing password file encrypter': (dependencies) =>
      dependencies.passwordFileEncrypter = PasswordFileEncrypter(
        contentEncrypter: dependencies.contentEncrypter,
      ),
  'Setting up talker for bloc': (dependencies) =>
      Bloc.observer = TalkerBlocObserver(talker: dependencies.talker),
  'Restore settings': (dependencies) async {
    // await Future.delayed(const Duration(seconds: 3));
  },
  // 'Migrate app from previous version': (dependencies) =>
  //     AppMigrator.migrate(dependencies.database),
  // 'Collect logs': (dependencies) async {
  //   if (Config.environment.isProduction) return;
  //   await (dependencies.database
  //           .select<LogTbl, LogTblData>(dependencies.database.logTbl)
  //         ..orderBy([
  //           (tbl) => OrderingTerm(expression: tbl.time, mode: OrderingMode.desc)
  //         ])
  //         ..limit(LogBuffer.bufferLimit))
  //       .get()
  //       .then<List<LogMessage>>((logs) => logs
  //           .map((l) => l.stack != null
  //               ? LogMessageWithStackTrace(
  //                   date: DateTime.fromMillisecondsSinceEpoch(l.time * 1000),
  //                   level: LogLevel.fromValue(l.level),
  //                   message: l.message,
  //                   stackTrace: StackTrace.fromString(l.stack!))
  //               : LogMessage(
  //                   date: DateTime.fromMillisecondsSinceEpoch(l.time * 1000),
  //                   level: LogLevel.fromValue(l.level),
  //                   message: l.message,
  //                 ))
  //           .toList())
  //       .then<void>(LogBuffer.instance.addAll);
  //   l
  //       .bufferTime(const Duration(seconds: 1))
  //       .where((logs) => logs.isNotEmpty)
  //       .listen(LogBuffer.instance.addAll);
  //   l
  //       .map<LogTblCompanion>((log) => LogTblCompanion.insert(
  //             level: log.level.level,
  //             message: log.message.toString(),
  //             time: Value<int>(log.date.millisecondsSinceEpoch ~/ 1000),
  //             stack: Value<String?>(switch (log) {
  //               LogMessageWithStackTrace l => l.stackTrace.toString(),
  //               _ => null
  //             }),
  //           ))
  //       .bufferTime(const Duration(seconds: 15))
  //       .where((logs) => logs.isNotEmpty)
  //       .listen(
  //         (logs) => dependencies.database
  //             .batch((batch) =>
  //                 batch.insertAll(dependencies.database.logTbl, logs))
  //             .ignore(),
  //         cancelOnError: false,
  //       );
  // },
  'Log app initialized': (_) async {
    // await Future.delayed(const Duration(seconds: 5));
  },
};
