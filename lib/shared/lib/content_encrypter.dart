import 'package:encrypt/encrypt.dart';

abstract interface class IContentEncrypter {
  String encrypt(String content, String secretKey);
  String decrypt(String content, String secretKey);
  String formatKey(String key);
  bool isValidKey(String key);
  int getBytesLength(String key);
}

class AESEncrypter implements IContentEncrypter {
  static const _keyLength = 32;
  static const _ivLength = 16;

  @override
  String encrypt(String content, String secretKey) {
    final key = formatKey(secretKey);

    final iv = IV.fromLength(_ivLength);
    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(key),
        mode: AESMode.ecb,
        padding: 'PKCS7',
      ),
    );

    final encrypted = encrypter.encrypt(content, iv: iv);
    return encrypted.base64;
  }

  @override
  String decrypt(String content, String secretKey) {
    if (content.isEmpty) return content;

    final key = formatKey(secretKey);

    final iv = IV.fromLength(_ivLength);
    final encrypter = Encrypter(AES(
      Key.fromUtf8(key),
      mode: AESMode.ecb,
      padding: 'PKCS7',
    ));
    return encrypter.decrypt(Encrypted.fromBase64(content), iv: iv);
  }

  @override
  String formatKey(String key) {
    if (Key.fromUtf8(key).length > _keyLength) {
      throw Exception('Key length must be less than $_keyLength bytes');
    }

    return key.padRight(_keyLength, '0');
  }

  @override
  bool isValidKey(String key) {
    return Key.fromUtf8(key).length <= _keyLength;
  }

  @override
  int getBytesLength(String key) {
    return Key.fromUtf8(key).length;
  }
}
