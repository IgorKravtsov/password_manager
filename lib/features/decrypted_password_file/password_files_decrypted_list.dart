import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

import 'package:password_manager/shared/lib/content_encrypter.dart';

import '_vm/cubit/password_files_decrypted_cubit.dart';

import '_ui/export_decrypted_file_button.dart';
import '_ui/password_files_tabs.dart';
import '_ui/search_segments.dart';
import '_ui/password_file_editable_segments.dart';

class PasswordFilesDecryptedList extends StatelessWidget {
  const PasswordFilesDecryptedList({super.key});

  PasswordFilesDecryptedCubit _createCubit(BuildContext context) {
    final configurationFileState = context.read<ConfigurationFileBloc>().state;
    return PasswordFilesDecryptedCubit(
      encrypter: PasswordFileEncrypter(contentEncrypter: AESEncrypter()),
      decryptedPasswordFileSaver: DecryptedPasswordFileSaver(),
    )
      ..decryptPasswordFiles(configurationFileState.configs);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: _createCubit,
      child:
          BlocBuilder<PasswordFilesDecryptedCubit, DecryptedPasswordFilesState>(
              builder: (context, state) {
        if (state is PasswordFilesDecryptionFailed) {
          return Text(state.message);
        }

        if (state.decryptedFiles.isEmpty) {
          return _buildEmptyState(context);
        }

        final selectedFileIndex = state.decryptedFiles
            .indexOf(state.selectedFile ?? state.decryptedFiles[0]);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              PasswordFilesTabs(
                selectedFileIndex: selectedFileIndex,
                decryptedFiles: state.decryptedFiles,
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchSegments(),
                  Spacer(),
                  ExportDecryptedFileButton(),
                ],
              ),
              const SizedBox(height: 20),
              PasswordFileEditableSegments(
                state.selectedFile ?? state.decryptedFiles[0],
              ),
            ],
          ),
        );
      }),
    );
  }

  Center _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('No files selected.'),
          ElevatedButton(
            onPressed: () {
              context.read<PasswordFilesDecryptedCubit>().decryptPasswordFiles(
                  context.read<ConfigurationFileBloc>().state.configs);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
