import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/generated/l10n.dart';

import 'package:password_manager/shared/lib/configuration_file_reader.dart';
import 'package:password_manager/shared/lib/dependencies/inherited_dependencies.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/page_title.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/shared/ui/screen_content.dart';

import 'package:password_manager/widgets/app_layout.dart';

import '_ui/password_files_list.dart';
import '_vm/bloc/password_files_bloc.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  PasswordFilesBloc _createBlocProvider(BuildContext context) {
    final state = context.read<ConfigurationFileBloc>().state;
    final bloc =
        PasswordFilesBloc(configFileReader: const ConfigurationFileReader());
    if (state is ConfigurationFileLoaded) {
      bloc.add(PasswordFilesLoad(state.configs));
    }
    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: _createBlocProvider,
      child: AppScaffold(
        selectedRoute: Location.files,
        floatingActionButton: Builder(builder: (context) {
          final confState = context.watch<ConfigurationFileBloc>().state;
          if (confState is! ConfigurationFileLoaded) {
            return const SizedBox();
          }
          return FloatingActionButton(
            onPressed: () => context
                .read<PasswordFilesBloc>()
                .add(const PasswordFilesAdd(pathToFile: '', secretKey: '')),
            child: const Icon(Icons.add),
          );
        }),
        child: const FilesScreenContent(),
      ),
    );
  }
}

class FilesScreenContent extends StatelessWidget {
  const FilesScreenContent({super.key});

  void _handleSaveFile(
      ConfigModel config, int index, BuildContext context) async {
    final configurationFileBloc = context.read<ConfigurationFileBloc>();

    if (configurationFileBloc.state is! ConfigurationFileLoaded) {
      return;
    }
    final configState = configurationFileBloc.state as ConfigurationFileLoaded;

    final completer = Completer<void>();
    context.read<PasswordFilesBloc>().add(PasswordFilesSave(
          pathToConfigFile: configState.path,
          config: config,
          index: index,
          completer: completer,
        ));
    await completer.future;
    configurationFileBloc.add(ConfigurationFileReload());
  }

  void _handleDeleteFile(
    ConfigModel config,
    int index,
    BuildContext context,
  ) async {
    final configurationFileBloc = context.read<ConfigurationFileBloc>();

    if (configurationFileBloc.state is! ConfigurationFileLoaded) {
      return;
    }
    final configState = configurationFileBloc.state as ConfigurationFileLoaded;
    final completer = Completer<void>();
    context.read<PasswordFilesBloc>().add(PasswordFilesRemove(
          index: index,
          pathToConfigFile: configState.path,
          completer: completer,
        ));

    await completer.future;
    configurationFileBloc.add(ConfigurationFileReload());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              PageTitle(text: S.of(context).passwordFilesConfiguration),
              BlocConsumer<PasswordFilesBloc, PasswordFilesState>(
                listener: (context, state) {
                  if (state is PasswordFilesError) {
                    _showErrorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  final configState =
                      context.read<ConfigurationFileBloc>().state;
                    
                if (configState is ConfigurationFileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                if (configState is! ConfigurationFileLoaded) {
                    return _buildErrorElements(context);
                }
                  return PasswordFilesList(
                    configs: state.configs,
                    onSaveFile: _handleSaveFile,
                    onDeleteFile: _handleDeleteFile,
                    encryptor: context.deps.contentEncrypter,
                  );
                },
              ),
            ],
        ),
      ),
    );
  }



  Widget _buildErrorElements(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        FilledButton(
          onPressed: () => context.go(Location.configuration),
          child: Text(
            S.of(context).someErrorOccuredPleaseGoToConfiguration,
          ),
        ),
      ],
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
