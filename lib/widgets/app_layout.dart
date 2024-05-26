import 'package:flutter/material.dart';
import 'package:password_manager/shared/ui/layout.dart';
import 'package:password_manager/shared/ui/main_bottom_navigation_bar.dart';
import 'package:password_manager/shared/ui/sidebar.dart';

class AppScaffold extends StatelessWidget {
  final String selectedRoute;
  final Widget? floatingActionButton;
  final Widget child;

  const AppScaffold({
    super.key,
    required this.selectedRoute,
    this.floatingActionButton,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout.builder(context, (_, type) {
        final children = <Widget>[child];
        if (type == Layout.desktop) {
          children.insert(0, Sidebar(selectedRoute: selectedRoute));
        }
        return Row(mainAxisSize: MainAxisSize.min, children: children);
      }),
      bottomNavigationBar: Layout.builder(context, (context, type) {
        if ([Layout.tablet, Layout.phone].contains(type)) {
          return MainBottomNavigationBar(selectedRoute: selectedRoute);
        }
        return const SizedBox();
      }),
      floatingActionButton: floatingActionButton,
    );
  }
}
