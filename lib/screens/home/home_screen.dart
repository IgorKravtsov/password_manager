
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/entities/config/_vm/bloc/configuration_file_bloc.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/widgets/app_layout.dart';

import '_ui/empty_state.dart';
import '_ui/password_files_decrypted_list.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      selectedRoute: Location.home,
      child: PasswordsContentDependingOnState(),
    );
  }
}

class PasswordsContentDependingOnState extends StatelessWidget {
  const PasswordsContentDependingOnState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationFileBloc, ConfigurationFileState>(
      builder: (context, state) {
        if (state is ConfigurationFileInitError ||
            state is ConfigurationFileError) {
          return const PasswordsEmptyState();
        }

        if (state is ConfigurationFileLoaded) {
          return const Expanded(child: PasswordFilesDecryptedList());
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

