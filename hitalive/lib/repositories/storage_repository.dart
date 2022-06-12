import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:hitalive/configs/configs.dart';

class StorageRepository {
  final FlutterSecureStorage storage;

  StorageRepository(this.storage);

  Future<String?> readSecure({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> writeSecure({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteSecure({required String key}) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllSecure() async {
    await storage.deleteAll();
  }

  Future<void> saveAuthentication({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(key: Constants.accessToken, value: accessToken);
    await storage.write(key: Constants.refreshToken, value: refreshToken);
  }
}
