import 'package:flutter/material.dart';

class ScreenContent extends StatelessWidget {
  final Widget child;
  const ScreenContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Flexible(fit: FlexFit.loose, child: child);
  }
}
