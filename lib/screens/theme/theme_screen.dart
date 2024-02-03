import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:password_manager/features/theme/theme.dart';

import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/page_title.dart';
import 'package:password_manager/shared/ui/ui_back_button.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
            const Row(children: [
              PageTitle(text: 'Theme'),
            ]),
            const SwitchThemeModeCard(),
            const SizedBox(height: 20),
            const ChangeColorCard()
          ],
        ),
      ),
    ));
  }
}
