import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';

class ConfigurationForm extends StatefulWidget {
  const ConfigurationForm({super.key});

  @override
  State<ConfigurationForm> createState() => _ConfigurationFormState();
}

class _ConfigurationFormState extends State<ConfigurationForm> {
  final _filePathController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final state = context.read<ConfigurationFileBloc>().state;

    if (state is ConfigurationFileLoaded) {
      _filePathController.text = state.path;
    }

    super.initState();
  }

  @override
  void dispose() {
    _filePathController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _handleSelectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null) return;

    _filePathController.text = result.files.single.path!;
  }

  void _handleSelectDirectory() async {
    final directory = await FilePicker.platform.getDirectoryPath();
    if (directory == null) return;

    _filePathController.text = directory;
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context
        .read<ConfigurationFileBloc>()
        .add(ConfigurationFileSelectFileOrDirectory(
          _filePathController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              BlocListener<ConfigurationFileBloc, ConfigurationFileState>(
                listener: (context, state) {
                  if (state is ConfigurationFileLoaded) {
                    state.configs.isEmpty
                        ? context.go(Location.files)
                        : context.go(Location.home);
                  }
                  if (state is ConfigurationFileError) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _filePathController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: S.of(context).filePath,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseEnterAValidPath;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: _handleSelectDirectory,
                          icon: const Icon(Icons.folder),
                          tooltip: S.of(context).chooseDirectory,
                        ),
                        const SizedBox(width: 10),
                        IconButton.outlined(
                          onPressed: _handleSelectFile,
                          icon: const Icon(Icons.file_open),
                          tooltip: S.of(context).chooseExistingFile,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              BlocBuilder<ConfigurationFileBloc, ConfigurationFileState>(
                builder: _buildSubmitButton,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSubmitButton(
      BuildContext context, ConfigurationFileState state) {
    final isLoading = state is ConfigurationFileLoading;
    return Container(
      constraints: const BoxConstraints(minWidth: 400, minHeight: 50),
      child: FilledButton(
        onPressed: () => isLoading ? null : _submit(context),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(S.of(context).save),
      ),
    );
  }
}
