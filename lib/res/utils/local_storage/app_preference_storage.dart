//app_preference_storage

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferenceStorage {
  // make this a singleton class
  AppPreferenceStorage._privateConstructor();

  static final AppPreferenceStorage instance =
      AppPreferenceStorage._privateConstructor();

  static String userId = 'userId';
  static String userName = "userName";
  static String signupWith = "signupWith";
  static String userEmail = "userEmail";
  static String userImage = "userImage";
  static String userCountry = "userCountry";
  static String countryCode = "countryCode";
  static String phoneNumber = "phoneNumber";
  static String verificationStatus = "verificationStatus";
  static String authToken = "authToken";
  static String selectedCountry = 'selectedCountry';
  static String deviceToken = 'deviceToken';

  static setStringValuesSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static setBoolValuesSF(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static setIntValuesSF(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static setDoubleValuesSF(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  //////////////////////////////////////////////////////////////////////////////

  static Future<String?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  static Future<bool?> getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(key);
    return boolValue;
  }

  static Future<int?> getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  static Future<double?> getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? doubleValue = prefs.getDouble(key);
    return doubleValue;
  }

  static Future<bool> clearPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.clear();
  }
}
