import 'dart:io';

import 'package:intl/intl.dart';

import '../password_file.dart';

abstract interface class IDecryptedPasswordFileSaver {
  Future<void> save(
    String path,
    List<PasswordFileSegmentModel> segments,
  );
}

class DecryptedPasswordFileSaver implements IDecryptedPasswordFileSaver {
  static const _segmentsDivider = '\n\n====================\n\n';
  static const _titleContentDivider = '\n******************************\n';

  @override
  Future<void> save(
    String path,
    List<PasswordFileSegmentModel> segments,
  ) async {
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    path = path.replaceFirst('.txt', '_$date.txt');
    final file = File(path);

    final content = segments
        .map((e) => '${e.title}$_titleContentDivider${e.content}')
        .join(_segmentsDivider);

    try {
      await file.create();
      await file.writeAsString(content);
    } catch (e) {
      rethrow;
    }
  }
}
