import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:password_manager/features/theme/theme.dart';
import 'package:password_manager/generated/l10n.dart';

import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/page_title.dart';
import 'package:password_manager/shared/ui/screen_content.dart';
import 'package:password_manager/shared/ui/ui_back_button.dart';
import 'package:password_manager/widgets/app_layout.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      selectedRoute: Location.settings,
      child: ThemeScreenContent(),
    );
  }
}

class ThemeScreenContent extends StatelessWidget {
  const ThemeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      child: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Row(children: [
                UIBackButton(
                  onTap: () => context.go(Location.settings),
                ),
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(children: [PageTitle(text: S.of(context).theme)]),
              const SwitchThemeModeCard(),
              const SizedBox(height: 20),
              const ChangeColorCard()
            ],
          ),
        ),
      ),
    );
  }
}
