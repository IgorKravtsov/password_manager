import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:meta/meta.dart';

import '../theme_configuration.dart';
import '../themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(theme: Themes.getTheme(null)));

  void changeTheme(String? id) {
    final theme = Themes.getTheme(id);
    emit(ChangeThemeOrMode(theme, state.mode));
  }

  void changeThemeMode(ThemeMode mode) {
    emit(ChangeThemeOrMode(state.theme, mode));
  }
}
