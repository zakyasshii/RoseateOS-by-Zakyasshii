import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class EncryptedHiveService {
  static const _keyName = 'hive_encryption_key';
  static final _secureStorage = const FlutterSecureStorage();

  static Future<Uint8List> _getEncryptionKey() async {
    String? key = await _secureStorage.read(key: _keyName);
    if (key == null) {
      final keyBytes = encrypt.Key.fromSecureRandom(32).bytes;
      key = base64UrlEncode(keyBytes);
      await _secureStorage.write(key: _keyName, value: key);
    }
    return base64Url.decode(key);
  }

  static Future<Box<T>> openEncryptedBox<T>(String boxName) async {
    final encryptionKey = await _getEncryptionKey();
    return await Hive.openBox<T>(boxName, encryptionCipher: HiveAesCipher(encryptionKey));
  }
} 