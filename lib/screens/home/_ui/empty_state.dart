import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/layout.dart';

class PasswordsEmptyState extends StatelessWidget {
  const PasswordsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout.builder(context, (context, type) {
      if ([Layout.desktop, Layout.tablet].contains(type)) {
        return _buildDesktop(context);
      }

      return _buildDesktop(context);
    });
  }

  Center _buildDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width < Layout.tabletWidth ? 25 : 60),
            child: Text(
              S.of(context).seemsLikeYouDontHavePasswordFilesSelected,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:
                    math.min(MediaQuery.of(context).size.width * 0.035, 32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 80),
          TextButton(
            onPressed: () => context.go(Location.configuration),
            child: Text(
              S.of(context).goToConfiguration,
              style: TextStyle(
                fontSize:
                    math.min(MediaQuery.of(context).size.width * 0.04, 32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
