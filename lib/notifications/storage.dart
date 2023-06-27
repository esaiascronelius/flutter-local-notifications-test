import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  // Storage instance.
  static const storage = FlutterSecureStorage();

  /// Get value from storage.
  /// Throws an [error] if the key does not exist.
  static Future<String?> get(String key, {bool throwOnFail = true}) async {
    final value = await storage.read(key: key);
    if (value == null) {
      if (throwOnFail) {
        throw Exception('$key not found in storage.');
      } else {
        return null;
      }
    }
    return value;
  }

  /// Set value to storage.
  static Future<void> set(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  /// Delete the value for the given [key].
  static Future<void> delete(String key) async {
    await storage.delete(key: key);
  }
}
