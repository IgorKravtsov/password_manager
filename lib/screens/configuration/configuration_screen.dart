import 'package:flutter/material.dart';

import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/page_title.dart';
import 'package:password_manager/shared/ui/screen_content.dart';
import 'package:password_manager/shared/ui/ui_back_button.dart';
import 'package:password_manager/widgets/app_layout.dart';

import '_ui/configuration_form.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      selectedRoute: Location.settings,
      child: ConfigurationScreenContent(),
    );
  }
}

class ConfigurationScreenContent extends StatelessWidget {
  const ConfigurationScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 40),
            Row(children: [
              UIBackButton(
                onTap: () => Navigator.of(context).pop(),
              ),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            PageTitle(text: S.of(context).configurationFileJson),
            const SizedBox(height: 50),
            Text(
              S.of(context).chooseDirectoryWhereToSaveConfigurationFile,
              textAlign: TextAlign.center,
            ),
            Text(
              S.of(context).or,
            ),
            Text(
              S.of(context).chooseExistingConfigurationFile,
            ),
            const ConfigurationForm(),
          ],
        ),
      ),
    );
  }
}
