import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }
  static Future setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  static Future setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future clear() async {
    await _prefs?.clear();
  }
}
