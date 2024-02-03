import 'package:hive_flutter/hive_flutter.dart';

abstract interface class IDatabase {
  Future<void> init();

  Future<void> savePathToConfigFile(String path);
  Future<String?> readPathToConfigFile();

  Future<void> saveIsDarkMode(bool isDarkMode);
  Future<bool?> readIsDarkMode();

  Future<void> saveThemeId(String themeId);
  Future<String?> readThemeId();

  Future<void> saveLastSelectedFilePath(String selectedFilePath);
  Future<String?> readLastSelectedFilePath();

  Future<void> saveLocale(String locale);
  Future<String?> readLocale();
}

class HiveDatabase implements IDatabase {
  static const _boxName = 'password_manager';

  late final Box _box;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> savePathToConfigFile(String path) async {
    await _box.put('pathToConfigFile', path);
  }

  @override
  Future<String?> readPathToConfigFile() {
    return Future(() => _box.get('pathToConfigFile'));
  }

  @override
  Future<void> saveIsDarkMode(bool isDarkMode) async {
    await _box.put('isDarkMode', isDarkMode);
  }

  @override
  Future<bool?> readIsDarkMode() {
    return Future(() => _box.get('isDarkMode'));
  }

  @override
  Future<void> saveThemeId(String themeId) async {
    await _box.put('themeId', themeId);
  }

  @override
  Future<String?> readThemeId() {
    return Future(() => _box.get('themeId'));
  }

  @override
  Future<void> saveLastSelectedFilePath(String selectedFilePath) async {
    await _box.put('lastSelectedFilePath', selectedFilePath);
  }

  @override
  Future<String?> readLastSelectedFilePath() {
    return Future(() => _box.get('lastSelectedFilePath'));
  }

  @override
  Future<String?> readLocale() {
    return Future(() => _box.get('locale'));
  }

  @override
  Future<void> saveLocale(String locale) async {
    await _box.put('locale', locale);
  }
}
