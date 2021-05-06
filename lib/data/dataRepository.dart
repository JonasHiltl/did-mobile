import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  Future write(String key, String value) async {
    final writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future read(String key) async {
    final readData = await _storage.read(key: key);
    return readData;
  }

  Future delete(String key) async {
    final deleteData = await _storage.delete(key: key);
    return deleteData;
  }

  Future<bool> contains(String key) async {
    final containsData = await _storage.containsKey(key: key);
    return containsData;
  }

  Future readAll() async {
    final allData = await _storage.readAll();
    return allData;
  }

  Future deleteAll() async {
    final deleteAllData = await _storage.deleteAll();
    return deleteAllData;
  }
}
