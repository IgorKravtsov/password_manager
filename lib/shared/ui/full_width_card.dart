import 'package:flutter/material.dart';
import 'package:password_manager/shared/ui/ui_card.dart';

class FullWidthCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double minHeight;

  const FullWidthCard({
    super.key,
    required this.child,
    this.onTap,
    this.minHeight = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: minHeight,
      ),
      child: UICard(onTap: onTap, child: child),
    );
  }
}
