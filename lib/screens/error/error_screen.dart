import 'package:flutter/material.dart';

class AppErrorScreen extends StatelessWidget {
  final String? message;
  const AppErrorScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 100),
          Text(message ?? 'An error occurred'),
        ],
      ),
    ));
  }
}
