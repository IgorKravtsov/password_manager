import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/entities/config/_vm/bloc/configuration_file_bloc.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/widgets/main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

import '_ui/password_files_decrypted_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConfigurationFileBloc, ConfigurationFileState>(
          builder: (context, state) {
            if (state is ConfigurationFileInitError) {
              return _buildEmptyState(context);
            }

            if (state is ConfigurationFileLoaded) {
              return const SingleChildScrollView(
                child: PasswordFilesDecryptedList(),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomNavigationBar: const MainBottomNavigationBar(currentIndex: 0));
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).seemsLikeYouDontHavePasswordFilesSelected,
            style: TextStyle(
              fontSize: math.min(MediaQuery.of(context).size.width * 0.035, 32),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 80),
          TextButton(
              onPressed: () => context.go(Location.configuration),
              child: Text(
                S.of(context).goToConfiguration,
                style: TextStyle(
                  fontSize:
                      math.min(MediaQuery.of(context).size.width * 0.04, 32),
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
