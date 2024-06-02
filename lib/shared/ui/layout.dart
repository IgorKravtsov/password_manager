import 'package:flutter/material.dart';

class Layout extends InheritedWidget {
  final int type;
  final Size size;

  static const phone = 0;
  static const tablet = 1;
  static const desktop = 2;

  static const desktopWidth = 1200;
  static const tabletWidth = 600;

  const Layout._({
    super.key,
    required super.child,
    required this.type,
    required this.size,
  });

  static Widget builder(
    BuildContext context,
    Widget Function(BuildContext context, int type) builder,
  ) {
    final size = MediaQuery.of(context).size;
    if (size.width >= desktopWidth) {
      return Layout._(
        type: desktop,
        size: size,
        child: builder(context, desktop),
      );
    }
    if (size.width >= tabletWidth) {
      return Layout._(
        type: tablet,
        size: size,
        child: builder(context, tablet),
      );
    }

    return Layout._(type: phone, size: size, child: builder(context, phone));
  }

  static isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidth;
  static isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletWidth &&
      MediaQuery.of(context).size.width < desktopWidth;
  static isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidth;

  static Layout of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Layout>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
