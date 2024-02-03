// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ConfigModel extends Equatable {
  final String id;
  final String pathToFile;
  final String secretKey;

  const ConfigModel({
    required this.id,
    required this.pathToFile,
    required this.secretKey,
  });

  @override
  List<Object> get props => [pathToFile, secretKey];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pathToFile': pathToFile,
      'secretKey': secretKey,
    };
  }

  @override
  String toString() =>
      'ConfigModel(id: $id, pathToFile: $pathToFile, secretKey: $secretKey)';

  @override
  bool get stringify => true;

  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
        id: const Uuid().v4(),
        pathToFile: map['pathToFile'],
        secretKey: map['secretKey']);
  }

  String toJson() => json.encode(toMap());

  factory ConfigModel.fromJson(String source) =>
      ConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ConfigModel copyWith({
    String? id,
    String? pathToFile,
    String? secretKey,
  }) {
    return ConfigModel(
      id: id ?? this.id,
      pathToFile: pathToFile ?? this.pathToFile,
      secretKey: secretKey ?? this.secretKey,
    );
  }
}
