import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorageHelper {
  final FlutterSecureStorage _storage;

  SecureStorageHelper(this._storage);

  Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    final string = json.encode(value);
    await _storage.write(key: key, value: string);
  }

  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  Future<Map<String, dynamic>?> getMap(String key) async {
    final string = await _storage.read(key: key);
    if (string != null) {
      return json.decode(string) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
