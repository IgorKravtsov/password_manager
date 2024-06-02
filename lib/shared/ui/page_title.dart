import 'package:flutter/material.dart';
import 'package:password_manager/shared/ui/layout.dart';

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
      textAlign: Layout.isPhone(context) ? TextAlign.center : TextAlign.start,
    );
  }
}
