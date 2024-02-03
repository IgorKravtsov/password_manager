import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'package:password_manager/app/router.dart';
import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/features/locale/locale.dart';
import 'package:password_manager/features/theme/theme.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/configuration_file_reader.dart';
import 'package:password_manager/shared/lib/database.dart';

class PasswordManagerApp extends StatelessWidget {
  const PasswordManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(database: GetIt.I<IDatabase>())..init(),
        ),
        BlocProvider(
          create: (_) => ConfigurationFileBloc(
            configFileReader: GetIt.I<IConfigurationFileReader>(),
            database: GetIt.I<IDatabase>(),
          )..add(
              ConfigurationFileInit(),
            ),
        ),
        BlocProvider(
          create: (_) => LocaleCubit(
            database: GetIt.I<IDatabase>(),
          )..init(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeState = context.watch<ThemeCubit>().state;
          final locale = context.watch<LocaleCubit>().state;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: themeState.theme.light,
            darkTheme: themeState.theme.dark,
            themeMode: themeState.mode,
            locale: locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
