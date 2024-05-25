import 'package:flutter/material.dart';

class InitializationSplashScreen extends StatelessWidget {
  final ValueNotifier<({int progress, String message})> notifier;

  const InitializationSplashScreen({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final progress = notifier.value.progress;
    final message = notifier.value.message;
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 100),
                const SizedBox(height: 20),
                const LinearProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  'Initializing $message... $progress%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
