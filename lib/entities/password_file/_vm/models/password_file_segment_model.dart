import 'dart:convert';

import 'package:equatable/equatable.dart';

class PasswordFileSegmentModel extends Equatable {
  final String title;
  final String content;
  final String? id;

  const PasswordFileSegmentModel({
    this.id,
    required this.title,
    required this.content,
  });

  PasswordFileSegmentModel copyWith({
    String? id,
    String? title,
    String? content,
  }) {
    return PasswordFileSegmentModel(
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
    };
  }

  factory PasswordFileSegmentModel.fromMap(Map<String, dynamic> map) {
    return PasswordFileSegmentModel(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordFileSegmentModel.fromJson(String source) =>
      PasswordFileSegmentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PasswordFileModel(title: $title, content: $content)';

  @override
  List<Object?> get props => [title, content];
}
