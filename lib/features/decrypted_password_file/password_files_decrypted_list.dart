import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

import 'package:password_manager/shared/lib/content_encrypter.dart';

import '_vm/cubit/password_files_decrypted_cubit.dart';
import '_ui/password_file_editable_segments.dart';

class PasswordFilesDecryptedList extends StatelessWidget {
  const PasswordFilesDecryptedList({super.key});

  PasswordFilesDecryptedCubit _createCubit(BuildContext context) {
    final configurationFileState = context.read<ConfigurationFileBloc>().state;
    return PasswordFilesDecryptedCubit(
        encrypter: PasswordFileEncrypter(contentEncrypter: AESEncrypter()))
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
          return const Text('No files selected.');
        }

        final selectedFileIndex = state.decryptedFiles
            .indexOf(state.selectedFile ?? state.decryptedFiles[0]);
        return Column(
          children: [
            DefaultTabController(
              initialIndex: selectedFileIndex == -1 ? 0 : selectedFileIndex,
              length: state.decryptedFiles.length,
              animationDuration: Durations.long1,
              child: TabBar(
                onTap: (value) => context
                    .read<PasswordFilesDecryptedCubit>()
                    .selectFile(state.decryptedFiles[value]),
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabs: state.decryptedFiles
                    .map((e) => Tab(text: e.fileName))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            PasswordFileEditableSegments(
              state.selectedFile ?? state.decryptedFiles[0],
            ),
          ],
        );
      }),
    );
  }
}
