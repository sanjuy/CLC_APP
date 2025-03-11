import 'package:shared_preferences/shared_preferences.dart';

class UserDefaults {
  UserDefaults._();
  static final UserDefaults _storage = UserDefaults._();
  static UserDefaults get shared => _storage;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveString({required String key, required String value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<void> saveInt({required String key, required int value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  Future<void> saveDouble({required String key, required double value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble(key);
  }

  Future<void> saveBool({required String key, required bool value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  remove({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }
}
