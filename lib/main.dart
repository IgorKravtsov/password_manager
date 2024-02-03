import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:platform_info/platform_info.dart';

import 'package:password_manager/entities/config/config.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/app/router.dart';
import 'package:password_manager/features/theme/theme.dart';
import 'package:password_manager/shared/lib/configuration_file.dart';

void main() {
  // Platform.I.locale;
  runApp(const PasswordManagerApp());
}

class PasswordManagerApp extends StatelessWidget {
  const PasswordManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ConfigurationFileBloc(configFileReader: ConfigurationFileReader())
                ..add(
                  ConfigurationFileInit(),
                ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final theme = state.theme;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: theme.light,
            darkTheme: theme.dark,
            themeMode: state.mode,
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
