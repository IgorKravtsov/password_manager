import 'package:flutter/material.dart';

import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/screens/settings/_ui/sync_card.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/page_title.dart';
import 'package:password_manager/shared/ui/screen_content.dart';
import 'package:password_manager/widgets/app_layout.dart';

import '_ui/configuration_card.dart';
import '_ui/language_card.dart';
import '_ui/theme_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      selectedRoute: Location.settings,
      child: SettingsScreenContent(),
    );
  }
}

class SettingsScreenContent extends StatelessWidget {
  const SettingsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PageTitle(text: S.of(context).settings),
            const SizedBox(height: 50),
            const ConfigurationCard(),
            const SizedBox(height: 20),
            const ThemeCard(),
            const SizedBox(height: 20),
            const LanguageCard(),
            const SizedBox(height: 20),
            const SyncCard(),
          ],
        ),
      ),
    );
  }
}
