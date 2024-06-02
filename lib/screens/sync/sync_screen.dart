import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/sync_github/bloc/connect_github_bloc.dart';

import 'package:password_manager/features/sync_github/sync_github.dart';
import 'package:password_manager/shared/lib/dependencies/inherited_dependencies.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/screen_content.dart';
import 'package:password_manager/widgets/app_layout.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      selectedRoute: Location.settings,
      child: SyncScreenContent(),
    );
  }
}

class SyncScreenContent extends StatelessWidget {
  const SyncScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final deps = context.deps;
    return ScreenContent(
      child: Center(
        child: BlocProvider(
          create: (context) => ConnectGithubBloc(
            database: deps.database,
            githubRepository: deps.githubRepository,
          ),
          child: const ConnectGithubButton(),
        ),
      ),
    );
  }
}
