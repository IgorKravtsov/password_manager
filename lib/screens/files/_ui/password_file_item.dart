import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/entities/config/_vm/models/config_model.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/screens/files/_vm/bloc/password_files_bloc.dart';
import 'package:password_manager/shared/lib/dart/extensions.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';
import 'package:password_manager/shared/ui/ui.dart';

class PasswordFileItem extends StatefulWidget {
  final ConfigModel config;
  final int index;
  final IContentEncrypter encryptor;

  final Function(ConfigModel config, int index, BuildContext context)? onDelete;
  final Function(ConfigModel config, int index, BuildContext context)? onSave;

  const PasswordFileItem({
    super.key,
    required this.config,
    required this.index,
    required this.encryptor,
    this.onDelete,
    this.onSave,
  });

  @override
  State<PasswordFileItem> createState() => _PasswordFileItemState();
}

class _PasswordFileItemState extends State<PasswordFileItem> {
  final _filePathController = TextEditingController();
  final _keyController = TextEditingController();

  void _handleSelectFile(BuildContext context) async {
    final filePath = await FilePicker.platform.saveFile(
      dialogTitle: S.of(context).pleaseSelectAnOutputFile,
      type: FileType.custom,
      fileName: 'passwords.txt',
      allowedExtensions: ['txt'],
    );
    if (filePath == null) return;

    _filePathController.text = filePath;
    setState(() {});
  }

  void _handleSave(BuildContext context) {
    widget.onSave?.call(
      ConfigModel(
        id: widget.config.id,
        pathToFile: _filePathController.text,
        secretKey: _keyController.text,
      ),
      widget.index,
      context,
    );
  }

  bool _isSaveDisabled() {
    if (_filePathController.text.isEmpty || _keyController.text.isEmpty) {
      return true;
    }
    if (!_filePathController.text.endsWith('.txt')) return true;
    return widget.config.pathToFile == _filePathController.text &&
        widget.config.secretKey == _keyController.text;
  }

  @override
  void initState() {
    _filePathController.text = widget.config.pathToFile;
    _keyController.text = widget.config.secretKey;
    super.initState();
  }

  @override
  void dispose() {
    _filePathController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _filePathController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: S.of(context).pathToEncryptedOrEmptyFile,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () => _handleSelectFile(context),
                child: Text(S.of(context).selectFile),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PasswrodInput(
            controller: _keyController,
            prefixIcon: IconButton(
              onPressed: () {
                _keyController.text = ''.getRandomString(32);
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
              tooltip: S.of(context).generateRandom32bytesKey,
            ),
            onChanged: (value) {
              if (!widget.encryptor.isValidKey(value)) {
                _keyController.text = value.substring(0, value.length - 1);
              }
              setState(() {});
            },
            labelText: S.of(context).secretKey,
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              onPressed: () => _showDeleteDialog(context),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(minWidth: 170, minHeight: 40),
              child: FilledButton(
                onPressed:
                    !_isSaveDisabled() ? () => _handleSave(context) : null,
                child: Text(S.of(context).save),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (innerContext) {
        return BlocProvider.value(
          value: context.watch<PasswordFilesBloc>(),
          child: AlertDialog(
            title: Text(S.of(context).areYouSureYouWantToDeleteThisFile),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                onPressed: () {
                  widget.onDelete?.call(widget.config, widget.index, context);
                  Navigator.of(context).pop();
                },
                style: const ButtonStyle().copyWith(
                  foregroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
                child: Text(S.of(context).delete),
              ),
            ],
          ),
        );
      },
    );
  }
}
