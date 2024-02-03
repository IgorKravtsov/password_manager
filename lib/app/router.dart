import 'package:go_router/go_router.dart';

import 'package:password_manager/shared/lib/location.dart';

import 'package:password_manager/screens/configuration/configuration.dart';
import 'package:password_manager/screens/files/files.dart';
import 'package:password_manager/screens/home/home.dart';
import 'package:password_manager/screens/settings/settings.dart';

final router = GoRouter(routes: [
  GoRoute(
    name: Location.home,
    path: Location.home,
    pageBuilder: (context, state) => Location.buildPage(
      context,
      state.pageKey,
      const HomeScreen(),
    ),
    routes: [
      GoRoute(
        path: Location.path(Location.files),
        pageBuilder: (context, state) {
          return Location.buildPage(
            context,
            state.pageKey,
            const FilesScreen(),
          );
        },
      ),
      GoRoute(
          path: Location.path(Location.settings),
          pageBuilder: (context, state) {
            return Location.buildPage(
              context,
              state.pageKey,
              const SettingsScreen(),
            );
          },
          routes: [
            GoRoute(
              path: Location.path(Location.configuration),
              pageBuilder: (context, state) {
                return Location.buildPage(
                  context,
                  state.pageKey,
                  const ConfigurationScreen(),
                );
              },
            )
          ]),
    ],
  ),
]);
