import 'package:shared_preferences/shared_preferences.dart';

class UserTokenPref {
  static SharedPreferences? _prefs;
  static const String _token = 'token';
  static const String _userId = 'userid';

  static Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<String?> setToken(String token) async {
    await _init();
    await _prefs!.setString(_token, token);
    _prefs!.reload();
    return token;
  }

  static Future<String?> getToken() async {
    await _init();
    return _prefs!.getString(_token);
  }

  static Future<bool> clearToken() async {
    await _init();
    await _prefs!.remove(_token);
    return true;
  }

  static Future<int?> setUserId(int userId) async {
    await _init();
    await _prefs!.setInt(_userId, userId);
    _prefs!.reload();
    return userId;
  }

  static Future<int?> getUserId() async {
    await _init();
    return _prefs!.getInt(_userId);
  }

  static Future<bool> clearUserId() async {
    await _init();
    await _prefs!.remove(_userId);
    return true;
  }
}