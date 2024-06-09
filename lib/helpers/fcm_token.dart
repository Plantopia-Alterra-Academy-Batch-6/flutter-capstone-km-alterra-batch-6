import 'package:shared_preferences/shared_preferences.dart';

class FcmTokenPref {
  static SharedPreferences? _prefs;
  static const String _token = 'fcm_token';

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
}
