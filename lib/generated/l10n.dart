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

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Configuration`
  String get configuration {
    return Intl.message(
      'Configuration',
      name: 'configuration',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Secure data`
  String get secureData {
    return Intl.message(
      'Secure data',
      name: 'secureData',
      desc: '',
      args: [],
    );
  }

  /// `Password files list`
  String get passwordFilesList {
    return Intl.message(
      'Password files list',
      name: 'passwordFilesList',
      desc: '',
      args: [],
    );
  }

  /// `Seems like you don\'t have password files selected.`
  String get seemsLikeYouDontHavePasswordFilesSelected {
    return Intl.message(
      'Seems like you don\'t have password files selected.',
      name: 'seemsLikeYouDontHavePasswordFilesSelected',
      desc: '',
      args: [],
    );
  }

  /// `Look configuration`
  String get lookConfiguration {
    return Intl.message(
      'Look configuration',
      name: 'lookConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `No files selected.`
  String get noFilesSelected {
    return Intl.message(
      'No files selected.',
      name: 'noFilesSelected',
      desc: '',
      args: [],
    );
  }

  /// `Maybe something with path to one of the files or secret key. Please try again.`
  String get maybeSomethingWithPathToOneOfTheFilesOr {
    return Intl.message(
      'Maybe something with path to one of the files or secret key. Please try again.',
      name: 'maybeSomethingWithPathToOneOfTheFilesOr',
      desc: '',
      args: [],
    );
  }

  /// `Password files configuration`
  String get passwordFilesConfiguration {
    return Intl.message(
      'Password files configuration',
      name: 'passwordFilesConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Please select an output file:`
  String get pleaseSelectAnOutputFile {
    return Intl.message(
      'Please select an output file:',
      name: 'pleaseSelectAnOutputFile',
      desc: '',
      args: [],
    );
  }

  /// `Path to encrypted or empty file`
  String get pathToEncryptedOrEmptyFile {
    return Intl.message(
      'Path to encrypted or empty file',
      name: 'pathToEncryptedOrEmptyFile',
      desc: '',
      args: [],
    );
  }

  /// `Select file`
  String get selectFile {
    return Intl.message(
      'Select file',
      name: 'selectFile',
      desc: '',
      args: [],
    );
  }

  /// `Generate random 32-bytes key`
  String get generateRandom32bytesKey {
    return Intl.message(
      'Generate random 32-bytes key',
      name: 'generateRandom32bytesKey',
      desc: '',
      args: [],
    );
  }

  /// `Secret key`
  String get secretKey {
    return Intl.message(
      'Secret key',
      name: 'secretKey',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this file?`
  String get areYouSureYouWantToDeleteThisFile {
    return Intl.message(
      'Are you sure you want to delete this file?',
      name: 'areYouSureYouWantToDeleteThisFile',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Configuration file (.json)`
  String get configurationFileJson {
    return Intl.message(
      'Configuration file (.json)',
      name: 'configurationFileJson',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message(
      'Dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Export decrypted .txt file`
  String get exportDecryptedTxtFile {
    return Intl.message(
      'Export decrypted .txt file',
      name: 'exportDecryptedTxtFile',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `No segments found`
  String get noSegmentsFound {
    return Intl.message(
      'No segments found',
      name: 'noSegmentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Add it!`
  String get addIt {
    return Intl.message(
      'Add it!',
      name: 'addIt',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item?`
  String get areYouSureYouWantToDeleteThisItem {
    return Intl.message(
      'Are you sure you want to delete this item?',
      name: 'areYouSureYouWantToDeleteThisItem',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Revert`
  String get revert {
    return Intl.message(
      'Revert',
      name: 'revert',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a content`
  String get pleaseEnterAContent {
    return Intl.message(
      'Please enter a content',
      name: 'pleaseEnterAContent',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a title`
  String get pleaseEnterATitle {
    return Intl.message(
      'Please enter a title',
      name: 'pleaseEnterATitle',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
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
