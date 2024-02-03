// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Choose directory where to save configuration file`
  String get chooseDirectoryWhereToSaveConfigurationFile {
    return Intl.message(
      'Choose directory where to save configuration file',
      name: 'chooseDirectoryWhereToSaveConfigurationFile',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `choose existing configuration file`
  String get chooseExistingConfigurationFile {
    return Intl.message(
      'choose existing configuration file',
      name: 'chooseExistingConfigurationFile',
      desc: '',
      args: [],
    );
  }

  /// `Choose directory`
  String get chooseDirectory {
    return Intl.message(
      'Choose directory',
      name: 'chooseDirectory',
      desc: '',
      args: [],
    );
  }

  /// `Choose existing file`
  String get chooseExistingFile {
    return Intl.message(
      'Choose existing file',
      name: 'chooseExistingFile',
      desc: '',
      args: [],
    );
  }

  /// `File path`
  String get filePath {
    return Intl.message(
      'File path',
      name: 'filePath',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid path`
  String get pleaseEnterAValidPath {
    return Intl.message(
      'Please enter a valid path',
      name: 'pleaseEnterAValidPath',
      desc: '',
      args: [],
    );
  }

  /// `Go to configuration`
  String get goToConfiguration {
    return Intl.message(
      'Go to configuration',
      name: 'goToConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Some error occured, please go to configuration`
  String get someErrorOccuredPleaseGoToConfiguration {
    return Intl.message(
      'Some error occured, please go to configuration',
      name: 'someErrorOccuredPleaseGoToConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `No files found. Press + to add one.`
  String get passwordFilesEmptyText {
    return Intl.message(
      'No files found. Press + to add one.',
      name: 'passwordFilesEmptyText',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
