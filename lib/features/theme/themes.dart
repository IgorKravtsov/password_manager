import 'package:flutter/material.dart' show Colors;

import 'theme_configuration.dart';

class Themes {
  //TODO: add translations for theme name
  static final List<Theme> _config = [
    Theme('a51qre', Colors.blueGrey, (context) => 'Default'),
    Theme('nhjw21', Colors.red, (context) => 'Red'),
    Theme('wtt4gh', Colors.pink, (context) => 'Pink'),
    Theme('cyrmcf', Colors.purple, (context) => 'purple'),
    Theme('ixdrxz', Colors.indigo, (context) => 'indigo'),
    Theme('sthadc', Colors.blue, (context) => 'blue'),
    Theme('bioujq', Colors.teal, (context) => 'teal'),
    Theme('wbchxy', Colors.green, (context) => 'green'),
    Theme('pqrrna', Colors.lime, (context) => 'lime'),
    Theme('jwvvet', Colors.yellow, (context) => 'yellow'),
    Theme('qncqbb', Colors.orange, (context) => 'orange'),
    Theme('sghdsn', Colors.brown, (context) => 'brown'),
  ];

  static Theme getTheme(String? id) => _config
      .firstWhere((element) => element.id == id, orElse: () => _config[0]);

  static List<Theme> getAll() => _config.toList();
}
