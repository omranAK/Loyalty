import 'package:shared_preferences/shared_preferences.dart';

//import '../model/user_model.dart';

class CacheManager {
  static const String key = "VALUE_LIST_KEY";
  static const String tokenKey = "VALUE_TOKEN";
  static late SharedPreferences _preferences;
  static String errorMessage = "ErrorMessage";
  static String loginModelKey = "LoginModel";
  static String lookupKey = "LookUp";
  static String userModellKey = "UserModel";
  static String userLoginModellKey = "UserModel";
  static String langKey = "LANG";

  CacheManager() {
    init();
  }

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static clearSharedPreferences() {
    _preferences.clear();
    _preferences.remove(tokenKey);
  }

  // static UserModel getUserModel() {
  //   Map<String, dynamic> json1 =
  //       json.decode(_preferences.getString(UserModellKey)!);
  //   UserModel userModel = UserModel.fromJson(json1);
  //   return userModel;
  // }
  //
  // static Future setUserModel(UserModel data) async {
  //   await _preferences.setString(UserModellKey, json.encode(data));
  // }
  //
  // static Future setUserLoginModel(UserModel data) async {
  //   await _preferences.setString(UserLoginModellKey, json.encode(data));
  // }

  static String? getUserLoginModel() {
    return _preferences.getString(userLoginModellKey);
  }

  static Future setValueList(String data) async {
    await _preferences.setString(key, data);
  }

  // static Future setLookup(LookUpModel data) async {
  //   await _preferences.setString(lookupKey, json.encode(data));
  // }

  // static Future setLoginModel(LoginModel data) async {
  //   await _preferences.setString(loginModelKey, json.encode(data));
  // }
  //
  // static LoginModel getLoginModel() {
  //   Map<String, dynamic> json1 =
  //       json.decode(_preferences.getString(loginModelKey)!);
  //   LoginModel login = LoginModel.fromJson(json1);
  //   return login;
  // }
  // static LookUpModel getLookup() {
  //   Map<String, dynamic> json1 =
  //   json.decode(_preferences.getString(lookupKey)!);
  //   LookUpModel lookUp = LookUpModel.fromJson(json1);
  //   return lookUp;
  // }
  static String? getValueList() {
    return _preferences.getString(key);
  }

  static Future setToken(String data) async {
    await _preferences.setString(tokenKey, data);
  }

  static String? getToken() {
    return _preferences.getString(tokenKey);
  }

  static Future setError(String? data) async {
    await _preferences.setString(errorMessage, data!);
  }

  static String? getError() {
    return _preferences.getString(errorMessage);
  }

  static Future setLang(String? data) async {
    await _preferences.setString(langKey, data!);
  }

  static String? getLang() {
    return _preferences.getString(langKey);
  }
}
