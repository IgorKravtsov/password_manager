import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/ui/layout.dart';

import '../_vm/cubit/password_files_decrypted_cubit.dart';

class ExportDecryptedFileButton extends StatelessWidget {
  const ExportDecryptedFileButton({
    super.key,
  });

  void _exportFile(BuildContext context) async {
    final cubit = context.read<PasswordFilesDecryptedCubit>();
    final directory = await FilePicker.platform.getDirectoryPath();

    if (directory == null) return;
    cubit.exportDecryptedFile(directory);
  }

  @override
  Widget build(BuildContext context) {
    return Layout.builder(context, (context, type) {
      if (type == Layout.tablet || type == Layout.phone) {
        return _buildMobile(context);
      }
      // return _buildDesktop(context);
      return _buildMobile(context);
    });
  }

  Widget _buildMobile(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: IconButton(
        tooltip: S.of(context).exportDecryptedTxtFile,
        onPressed: () => _exportFile(context),
        icon: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: FilledButton(
        onPressed: () => _exportFile(context),
        child: Text(S.of(context).exportDecryptedTxtFile),
      ),
    );
  }
}
