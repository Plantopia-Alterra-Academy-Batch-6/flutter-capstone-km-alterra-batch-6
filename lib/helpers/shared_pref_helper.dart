import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _userLatitudeKey = 'userLatitude';
  static const String _userLongitudeKey = 'userLongitude';
  static const String _userSearchHistoryKey = 'userSearchPlantHistory';

  static Future<void> saveUserLocation(
      double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_userLatitudeKey, latitude);
    await prefs.setDouble(_userLongitudeKey, longitude);

    double? savedLatitude = await getUserLatitude();
    double? savedLongitude = await getUserLongitude();
    if (kDebugMode) {
      print('$savedLatitude $savedLongitude');
    }
  }

  static Future<double?> getUserLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_userLatitudeKey);
  }

  static Future<double?> getUserLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_userLongitudeKey);
  }

  static Future<void> storeUserSearchHistory(String searchedPlantName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_userSearchHistoryKey, [searchedPlantName]);
    var userHistory = prefs.getStringList(_userSearchHistoryKey);
    if (kDebugMode) {
      print('$userHistory');
    }
  }
}
