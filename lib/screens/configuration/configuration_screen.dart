import 'package:flutter/material.dart';
import 'package:password_manager/generated/l10n.dart';

import '_ui/configuration_form.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
    );
  }
}
