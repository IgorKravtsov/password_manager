import 'package:flutter/material.dart';

class UIBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const UIBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }
}
