import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;
  const PageTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle().copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }
}
