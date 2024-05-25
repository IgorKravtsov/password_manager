import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/shared/lib/location.dart';

class MenuItem {
  final String route;
  final String title;
  final IconData icon;

  const MenuItem({
    required this.route,
    required this.title,
    required this.icon,
  });
}

class Sidebar extends StatelessWidget {
  final String selectedRoute;
  const Sidebar({
    super.key,
    required this.selectedRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
        minWidth: 200,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MenuItem(
              route: Location.home,
              title: 'Home',
              icon: Icons.folder,
            ),
            const MenuItem(
              route: Location.files,
              title: 'Files',
              icon: Icons.list_alt,
            ),
            const MenuItem(
              route: Location.settings,
              title: 'Settings',
              icon: Icons.settings,
            )
          ].map((route) => _buildItem(context, route)).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, MenuItem item) {
    // const borderRadius = BorderRadius.only(
    //     topRight: Radius.circular(32), bottomRight: Radius.circular(32));
    final borderRadius = BorderRadius.circular(8);
    return Column(
      children: [
        ListTile(
          onTap: () => context.go(item.route),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          title: Text(
            item.title,
            style: const TextStyle().copyWith(fontSize: 18),
          ),
          leading: Icon(item.icon),
          selected: selectedRoute == item.route,
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
