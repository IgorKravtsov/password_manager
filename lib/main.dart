import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password_manager/app/app.dart';
import 'package:password_manager/screens/error/error.dart';
import 'package:password_manager/screens/splash/splash.dart';

import 'package:password_manager/shared/lib/dependencies/inherited_dependencies.dart';
import 'package:password_manager/shared/lib/dependencies/initialization.dart';
// import 'package:platform_info/platform_info.dart';


// void main() async {
//   // Platform.I.locale;
//   await initDependencies();
//   runApp(const PasswordManagerApp());
// }

/// Entry point of the app.
/// Initializes the app and prepares it for use.
void main() => runZonedGuarded<void>(
      () async {
        // Splash screen
        final initializationProgress =
            ValueNotifier<({int progress, String message})>(
                (progress: 0, message: ''));
        initializationProgress.addListener(
          () => runApp(
              InitializationSplashScreen(notifier: initializationProgress)),
        );

        $initializeApp(
          onProgress: (progress, message) {
            initializationProgress.value =
                (progress: progress, message: message);
          },
          onSuccess: (dependencies) => runApp(
            InheritedDependencies(
              dependencies: dependencies,
              child: const PasswordManagerApp(),
            ),
          ),
          onError: (error, stackTrace) {
            runApp(const AppErrorScreen());
            // ErrorUtil.logError(error, stackTrace).ignore();
          },
        ).ignore();
      },
      // l.e,
      (error, stackTrace) {},
    );

/// Formats the log message.
Object _messageFormatting(Object message, DateTime now) =>
    '${_timeFormat(now)} | $message';

/// Formats the time.
String _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
