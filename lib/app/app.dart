import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:password_manager/generated/l10n.dart';

import 'package:password_manager/app/router.dart';
import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/features/locale/locale.dart';
import 'package:password_manager/features/theme/theme.dart';
import 'package:password_manager/shared/lib/dependencies/inherited_dependencies.dart';

class PasswordManagerApp extends StatelessWidget {
  const PasswordManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final deps = context.deps;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(database: deps.database)..init(),
        ),
        BlocProvider(
          create: (_) => ConfigurationFileBloc(
            configFileReader: deps.configurationFileReader,
            database: deps.database,
          )..add(
              ConfigurationFileInit(),
            ),
        ),
        BlocProvider(
          create: (_) => LocaleCubit(
            database: deps.database,
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
