import 'package:flutter/material.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/ui/page_title.dart';
import 'package:password_manager/shared/ui/ui_back_button.dart';

import '_ui/configuration_form.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
        ),
      ),
    );
  }
}
