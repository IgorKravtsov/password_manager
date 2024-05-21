import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/generated/l10n.dart';

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
        context.go({
              0: Location.home,
              1: Location.files,
              2: Location.settings,
            }[index] ??
            Location.home);
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.folder_open,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(Icons.folder),
          label: S.of(context).secureData,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.list_alt,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(Icons.list_alt),
          label: S.of(context).passwordFilesList,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.settings,
            color: theme.colorScheme.primary,
          ),
          icon: const Icon(Icons.settings),
          label: S.of(context).settings,
        ),
      ],
    );
  }
}
