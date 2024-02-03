import 'package:password_manager/entities/password_file/_vm/models/password_file_segment_model.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';

abstract interface class IPasswordFileEncrypter {
  Future<List<PasswordFileSegmentModel>> decryptSegments(
      String content, String secretKey);
  Future<String> encryptSegments(
    List<PasswordFileSegmentModel> models,
    String secretKey,
  );
}

class PasswordFileEncrypter implements IPasswordFileEncrypter {
  final String segmentsDivider;
  final String titleContentDivider;

  late final IContentEncrypter _contentEncrypter;

  PasswordFileEncrypter({
    required IContentEncrypter contentEncrypter,
    this.segmentsDivider = '\n\n====================\n\n',
    this.titleContentDivider = '\n******************************\n',
  }) {
    _contentEncrypter = contentEncrypter;
  }

  @override
  Future<List<PasswordFileSegmentModel>> decryptSegments(
    String content,
    String secretKey,
  ) async {
    final segments =
        _contentEncrypter.decrypt(content, secretKey).split(segmentsDivider);

    List<PasswordFileSegmentModel> result = [];
    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      if (segment.isEmpty) continue;

      final titleContent = segment.split(titleContentDivider);
      if (titleContent.length != 2) {
        throw Exception('Invalid segment: $segment, index: $i');
      }

      result.add(PasswordFileSegmentModel(
        title: titleContent[0],
        content: titleContent[1],
      ));
    }
    return result;
  }

  @override
  Future<String> encryptSegments(
    List<PasswordFileSegmentModel> models,
    String secretKey,
  ) async {
    String result = '';
    for (int i = 0; i < models.length; i++) {
      final model = models[i];
      result += '${model.title}$titleContentDivider${model.content}';

      if (i != models.length - 1) {
        result += segmentsDivider;
      }
    }
    return _contentEncrypter.encrypt(result, secretKey);
  }
}
