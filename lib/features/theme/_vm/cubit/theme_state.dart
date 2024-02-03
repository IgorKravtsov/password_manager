part of 'theme_cubit.dart';

final class ThemeState extends Equatable {
  final Theme theme;
  final ThemeMode mode;

  const ThemeState({required this.theme, required this.mode});

  ThemeState copyWith({
    Theme? theme,
    ThemeMode? mode,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object?> get props => [theme, mode];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.theme}) : super(mode: ThemeMode.system);
}

