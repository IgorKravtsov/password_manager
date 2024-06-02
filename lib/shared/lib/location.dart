import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Location {
  static const home = '/';
  static const files = '/files';
  static const settings = '/settings';
  static const theme = '/settings/theme';
  static const configuration = '/settings/config';
  static const sync = '/settings/sync';

  static String path(String path) {
    return path.substring(path.lastIndexOf('/') + 1, path.length);
  }

  static Page buildPage(BuildContext context, LocalKey? key, Widget child) {
    return CustomTransitionPage(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 150),
      key: key,
      child: child,
    );
  }
}
