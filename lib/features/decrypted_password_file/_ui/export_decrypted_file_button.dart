import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/decrypted_password_file/_vm/cubit/password_files_decrypted_cubit.dart';
import 'package:password_manager/shared/ui/layout.dart';

class ExportDecryptedFileButton extends StatelessWidget {
  const ExportDecryptedFileButton({
    super.key,
  });

  void _exportFile(BuildContext context) async {
    final vm = context.read<PasswordFilesDecryptedCubit>();
    final directory = await FilePicker.platform.getDirectoryPath();

    if (directory == null) return;
    vm.exportDecryptedFile(directory);
  }

  @override
  Widget build(BuildContext context) {
    return Layout.builder(context, (context, type) {
      if (type == Layout.tablet || type == Layout.phone) {
        return _buildMobile(context);
      }
      return _buildDesktop(context);
    });
  }

  Widget _buildMobile(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: IconButton(
        tooltip: 'Export decrypted .txt file',
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
        child: const Text('Export decrypted .txt file'),
      ),
    );
  }
}
