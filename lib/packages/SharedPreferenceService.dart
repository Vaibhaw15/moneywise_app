import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferenceService._internal();

  static Future<SharedPreferenceService> getInstance() async {
    _instance ??= SharedPreferenceService._internal();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Save Methods
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Get Methods
  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  static int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Remove a key
  static Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all data
  static Future<void> clear() async {
    await _preferences?.clear();
  }
}
