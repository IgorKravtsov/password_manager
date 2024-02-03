import 'dart:async';
import 'dart:convert';
import 'dart:io';

abstract interface class IConfigurationFileReader {
  Future<File> getOrCreate(String? path);
  Future<List<Map<String, dynamic>>> read(String? path);
  Future<void> save(String? path, List<Map<String, dynamic>> content);
}

class ConfigurationFileReader implements IConfigurationFileReader {
  static const _standardConfigurationFileName =
      'password_manager_configuration.json';

  const ConfigurationFileReader();

  bool _isValid(String? path) => path != null && path.isNotEmpty;

  bool _isFile(String? path) =>
      path != null &&
      path.split('/').last.contains('.') &&
      !path.endsWith('/') &&
      !path.endsWith('\\') &&
      path.endsWith('.json');

  @override
  Future<File> getOrCreate(String? path) async {
    if (!_isValid(path)) throw Exception('Path is invalid');

    try {
      if (!_isFile(path)) {
        if (!await Directory(path!).exists()) {
          throw Exception('Directory does not exist');
        }
        return _safeCreateFile('$path/$_standardConfigurationFileName');
      }
      return _safeCreateFile(path!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> read(String? path) async {
    if (!_isValid(path)) throw Exception('Path is invalid');

    try {
      final pathToFile =
          _isFile(path) ? path! : '$path/$_standardConfigurationFileName';
      final content = await File(pathToFile).readAsString();

      if (content.isEmpty) {
        return [];
      }

      return (json.decode(content) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> save(String? path, List<Map<String, dynamic>> content) async {
    if (!_isValid(path)) throw Exception('Path is invalid');

    try {
      final pathToFile =
          _isFile(path) ? path! : '$path/$_standardConfigurationFileName';
      await File(pathToFile).writeAsString(json.encode(content));
    } catch (e) {
      rethrow;
    }
  }

  Future<File> _safeCreateFile(String path) async {
    final file = File(path);
    if (await file.exists()) return file;
    await file.create();
    return file;
  }
}
