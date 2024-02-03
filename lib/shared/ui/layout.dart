import 'package:flutter/material.dart';

class Layout extends InheritedWidget {
  final int type;
  final Size size;

  static const phone = 0;
  static const tablet = 1;
  static const desktop = 2;

  const Layout({
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
    if (size.width >= 1200) {
      return Layout(
          type: desktop, size: size, child: builder(context, desktop));
    }
    if (size.width >= 600) {
      return Layout(type: tablet, size: size, child: builder(context, tablet));
    }

    return Layout(type: phone, size: size, child: builder(context, phone));
  }

  static Layout of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Layout>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  bool isPhone() => type == phone;
  bool isTablet() => type == tablet;
  bool isDesktop() => type == desktop;
}
