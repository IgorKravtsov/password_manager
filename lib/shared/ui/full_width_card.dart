import 'package:flutter/material.dart';
import 'package:password_manager/shared/ui/ui_card.dart';

class FullWidthCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const FullWidthCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: UICard(onTap: onTap, child: child),
    );
  }
}
