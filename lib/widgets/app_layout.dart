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
    required this.child,
    required this.selectedRoute,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout.builder(context, (context, type) {
        final children = <Widget>[child];
        if (type == Layout.desktop) {
          children.insert(0, Sidebar(selectedRoute: selectedRoute));
        }
        return Row(mainAxisSize: MainAxisSize.min, children: children);
      }),
      bottomNavigationBar: Layout.builder(context, (context, type) {
        if (type == Layout.tablet || type == Layout.phone) {
          return MainBottomNavigationBar(selectedRoute: selectedRoute);
        }
        //TODO: remove for desktop size, because we will have a sidebar
        // return const MainBottomNavigationBar(currentIndex: 0);
        return const SizedBox();
      }),
      floatingActionButton: floatingActionButton,
    );
  }
}
