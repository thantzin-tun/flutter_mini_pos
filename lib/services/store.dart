import 'package:shared_preferences/shared_preferences.dart';

class StoreSharePreferences {
  const StoreSharePreferences._();

  static Future<void> setStoreValueFunc(String key, dynamic value) async {
    final preferences = await SharedPreferences.getInstance();
    if (value is String) {
      await preferences.setString(key, value);
    } else if (value is int) {
      await preferences.setInt(key, value);
    } else if (value is bool) {
      await preferences.setBool(key, value);
    } else if (value is double) {
      await preferences.setDouble(key, value);
    } else if (value is List<String>) {
      await preferences.setStringList(key, value);
    } else {
      throw Exception("Invalid value type");
    }
  }

  static Future<String?> getStoreValueFunc(String storeKey) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(storeKey);
  }

  static Future<void> clearStoreValueFunc(String tokenKey) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(tokenKey);
  }
}
