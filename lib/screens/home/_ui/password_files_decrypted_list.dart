import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/features/decrypted_password_file/decrypted_password_file.dart';
import 'package:password_manager/generated/l10n.dart';

import 'package:password_manager/shared/lib/database.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/ui_card.dart';

class PasswordFilesDecryptedList extends StatelessWidget {
  const PasswordFilesDecryptedList({super.key});

  PasswordFilesDecryptedCubit _createCubit(BuildContext context) {
    final configurationFileState = context.read<ConfigurationFileBloc>().state;
    return PasswordFilesDecryptedCubit(
      encrypter: GetIt.I<IPasswordFileEncrypter>(),
      decryptedPasswordFileSaver: GetIt.I<IDecryptedPasswordFileSaver>(),
      database: GetIt.I<IDatabase>(),
    )..decryptPasswordFiles(configurationFileState.configs);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: _createCubit,
      child: BlocListener<ConfigurationFileBloc, ConfigurationFileState>(
        listener: (context, state) {
          if (state is ConfigurationFileLoaded) {
            context
                .read<PasswordFilesDecryptedCubit>()
                .decryptPasswordFiles(state.configs);
          }
        },
        child: BlocBuilder<PasswordFilesDecryptedCubit,
            DecryptedPasswordFilesState>(builder: (context, state) {
          if (state is PasswordFilesDecryptionFailed) {
            return Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 6),
              child: UICard(
                child: Column(
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle().copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      S.of(context).maybeSomethingWithPathToOneOfTheFilesOr,
                      style: const TextStyle().copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        context.go(Location.files);
                      },
                      child: Text(S.of(context).lookConfiguration),
                    ),
                    const SizedBox(height: 10),
                    Text(S.of(context).or.toUpperCase()),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () {
                        context
                            .read<PasswordFilesDecryptedCubit>()
                            .decryptPasswordFiles(context
                                .read<ConfigurationFileBloc>()
                                .state
                                .configs);
                      },
                      child: Text(S.of(context).retry),
                    ),
                  ],
                ),
              ),
            );
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
      ),
    );
  }

  Center _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).noFilesSelected),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<PasswordFilesDecryptedCubit>()
                    .decryptPasswordFiles(
                        context.read<ConfigurationFileBloc>().state.configs);
              },
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }
}
