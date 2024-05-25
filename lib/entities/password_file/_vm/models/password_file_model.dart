import 'package:equatable/equatable.dart';
import 'package:password_manager/entities/password_file/password_file.dart';

class PasswordFileModel extends Equatable {
  final String pathToFile;
  final String secretKey;
  final List<PasswordFileSegmentModel> segments;
  final bool? isError;
  final String? errorMessage;

  const PasswordFileModel({
    required this.secretKey,
    required this.pathToFile,
    required this.segments,
    this.isError = false,
    this.errorMessage,
  });

  PasswordFileModel copyWith({
    String? secretKey,
    String? pathToFile,
    List<PasswordFileSegmentModel>? segments,
  }) {
    return PasswordFileModel(
      secretKey: secretKey ?? this.secretKey,
      pathToFile: pathToFile ?? this.pathToFile,
      segments: segments ?? this.segments,
    );
  }

  String get fileName => pathToFile.split('/').last;

  @override
  List<Object?> get props =>
      [pathToFile, segments, secretKey, isError, errorMessage];
}
