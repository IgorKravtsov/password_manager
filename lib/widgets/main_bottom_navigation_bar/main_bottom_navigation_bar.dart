import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/shared/lib/location.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const MainBottomNavigationBar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(Location.home);
            break;
          case 1:
            context.go(Location.files);
            break;
          case 2:
            context.go(Location.settings);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.folder_open,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(Icons.folder),
          label: 'Password Files',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.lock,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(Icons.list_alt),
          label: 'Password files list',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.settings_applications,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
