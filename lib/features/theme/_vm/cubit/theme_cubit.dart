import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:password_manager/shared/lib/database.dart';
import 'package:password_manager/shared/lib/theme_configuration.dart';

import '../themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final IDatabase _database;

  ThemeCubit({required IDatabase database})
      : super(ThemeInitial(theme: Themes.getTheme(null))) {
    _database = database;
  }

  void init() async {
    final isDarkModeOrNull = await _database.readIsDarkMode() ?? false;
    final themeId = await _database.readThemeId();
    final theme = Themes.getTheme(themeId);

    emit(state.copyWith(
      theme: theme,
      mode: isDarkModeOrNull ? ThemeMode.dark : ThemeMode.light,
    ));
  }

  void changeTheme(String id) async {
    final theme = Themes.getTheme(id);
    await _database.saveThemeId(id);
    emit(state.copyWith(theme: theme));
  }

  void changeThemeMode(ThemeMode mode) async {
    await _database.saveIsDarkMode(mode == ThemeMode.dark);
    emit(state.copyWith(mode: mode));
  }
}
