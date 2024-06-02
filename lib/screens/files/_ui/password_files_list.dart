import 'package:flutter/material.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/screens/files/_ui/password_file_item.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';

class PasswordFilesList extends StatelessWidget {
  final List<ConfigModel> configs;
  final IContentEncrypter encryptor;
  final Function(ConfigModel config, int index, BuildContext context)?
      onSaveFile;
  final Function(ConfigModel config, int index, BuildContext context)?
      onDeleteFile;

  const PasswordFilesList({
    super.key,
    required this.configs,
    this.onSaveFile,
    this.onDeleteFile,
    required this.encryptor,
  });

  @override
  Widget build(BuildContext context) {
    return configs.isEmpty
        ? _buildEmptyState(context)
        : Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, i) => PasswordFileItem(
                key: ValueKey(configs[i].id),
                index: i,
                encryptor: encryptor,
                config: configs[i],
                onDelete: onDeleteFile,
                onSave: onSaveFile,
              ),
              itemCount: configs.length,
            ),
          );


  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(child: Text(S.of(context).passwordFilesEmptyText));
  }
}
