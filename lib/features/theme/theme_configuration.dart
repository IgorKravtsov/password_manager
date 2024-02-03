import 'package:flutter/material.dart';

class Theme {
  final Color color;
  final String id;
  final String Function(BuildContext) name;

  const Theme(
    this.id,
    this.color,
    this.name,
  );

  ThemeData get light => _buildTheme(Brightness.light);
  ThemeData get dark => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    final scheme =
        ColorScheme.fromSeed(seedColor: color, brightness: brightness);

    return ThemeData.from(
      colorScheme: scheme.copyWith(
          background: Color.alphaBlend(
              scheme.primary.withOpacity(0.05), scheme.background)),
      useMaterial3: true,
    ).copyWith(
      highlightColor: scheme.surfaceVariant.withOpacity(0.75),
      hoverColor: scheme.surfaceVariant.withOpacity(0.5),
      splashColor: scheme.surfaceVariant,
    );
  }

  Theme copyWith({
    String? id,
    Color? color,
    String Function(BuildContext)? name,
    ThemeMode? mode,
  }) {
    return Theme(
      id ?? this.id,
      color ?? this.color,
      name ?? this.name,
    );
  }
}
