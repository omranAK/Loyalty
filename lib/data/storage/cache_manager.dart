import 'dart:convert';
import 'package:loyalty_system_mobile/data/models/user_setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../model/user_model.dart';

class CacheManager {
  static const String key = "VALUE_LIST_KEY";
  static const String tokenKey = "VALUE_TOKEN";
  static SharedPreferences? _preferences;
  static String errorMessage = "ErrorMessage";
  static String loginModelKey = "LoginModel";
  static String lookupKey = "LookUp";
  static String userModellKey = "UserModel";
  static String userLoginModellKey = "UserModel";
  static String langKey = "LANG";
  static String pointsKey = "pointsKey";
  static String roleIdKey = "roleId";
  static String spicialKey = 'spicial';

  CacheManager() {
    init();
  }

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static clearSharedPreferences() async {
    await _preferences!.clear();
    await _preferences!.remove(userModellKey);
    await _preferences!.remove(tokenKey);
    await _preferences!.remove(pointsKey);

    await _preferences!.remove(spicialKey);
  }

  static UserSetting? getUserModel() {
    if (_preferences!.getString(userModellKey) != null) {
      Map<String, dynamic> json1 =
          json.decode(_preferences!.getString(userModellKey)!);
      UserSetting userModel = UserSetting.fromJson(json1);
      return userModel;
    } else {
      return null;
    }

    // Map<String, dynamic> valueMap = json.decode(json1) as Map<String, dynamic>

    // String s = _preferences!.getString(userModellKey)!;
    // print(json.decode(s));
    // Map<String, dynamic> sss = {};
    // UserSetting userModel = UserSetting.fromJson(sss);
    // return userModel;
  }

  static Future setUserModel(UserSetting data) async {
    await _preferences!.setString(userModellKey, json.encode(data));
  }

  // static Future setUserLoginModel(UserModel data) async {
  //   await _preferences.setString(UserLoginModellKey, json.encode(data));
  // }

  // static String? getUserLoginModel() {
  //   return _preferences!.getString(userLoginModellKey);
  // }

  // static Future setValueList(String data) async {
  //   await _preferences!.setString(key, data);
  // }

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
    return _preferences!.getString(key);
  }

  static Future setToken(String data) async {
    await _preferences!.setString(tokenKey, data);
  }

  static String? getToken() {
    return _preferences!.getString(tokenKey);
  }

  static Future setError(String? data) async {
    await _preferences!.setString(errorMessage, data!);
  }

  static String? getError() {
    return _preferences!.getString(errorMessage);
  }

  static Future setLang(String? data) async {
    await _preferences!.setString(langKey, data!);
  }

  static String? getLang() {
    return _preferences!.getString(langKey);
  }

  static Future? setPoint(String data) async {
    await _preferences!.setString(pointsKey, data);
  }

  static String? getPoint() {
    return _preferences!.getString(pointsKey);
  }

  static Future? setRoleId(int data) async {
    await _preferences!.setInt(roleIdKey, data);
  }

  static int? getRoleId() {
    return _preferences!.getInt(roleIdKey);
  }

  static Future? setSpicialPoint(String data) async {
    await _preferences!.setString(spicialKey, data);
  }

  static String? getSpicialPoint() {
    return _preferences!.getString(spicialKey);
  }
}
