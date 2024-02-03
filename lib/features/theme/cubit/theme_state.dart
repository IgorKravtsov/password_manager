part of 'theme_cubit.dart';

@immutable
sealed class ThemeState extends Equatable {
  final Theme theme;
  final ThemeMode mode;

  const ThemeState({required this.theme, required this.mode});

  @override
  List<Object?> get props => [theme, mode];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.theme}) : super(mode: ThemeMode.system);
}

final class ChangeThemeOrMode extends ThemeState {
  const ChangeThemeOrMode(Theme theme, ThemeMode mode)
      : super(theme: theme, mode: mode);
}
