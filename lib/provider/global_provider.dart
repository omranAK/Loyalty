import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/constant/theme_constant.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

class GlobalProvider extends ChangeNotifier {
  String _phoneCode = '974';
  String _phoneNumber = '';
  String _nationality = 'Qatar';
  ThemeData _theme = lightTheme;

  Locale _locale = const Locale('ar');

  int _currentIndex = 0;

  bool _mainRoute = true;
  bool _secondRoute = false;

  Locale get locale => _locale;

  int get currentIndex => _currentIndex;

  String get phoneCode => _phoneCode;
  String get phoneNumber => _phoneNumber;
  String get nationality => _nationality;

  bool get mainRoute => _mainRoute;
  bool get secondRoute => _secondRoute;

  //
  // void switchLanguage(Locale newLocale) {
  //   _locale = newLocale;
  //   notifyListeners();
  // }

  void updateLanguage() {
    if (_locale == const Locale('ar')) {
      _locale = const Locale('en');
      CacheManager.setLang('en');
      notifyListeners();
    } else {
      _locale = const Locale('ar');
      CacheManager.setLang('ar');
      notifyListeners();
    }
  }

  void updateTheme() {
    if (_theme == lightTheme) {
      _theme = darkTheme;
      CacheManager.setTheme('dark');
      notifyListeners();
    } else {
      _theme = lightTheme;
      CacheManager.setTheme('light');
      notifyListeners();
    }
  }

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void updatePhoneCode(String data) {
    _phoneCode = data;
    notifyListeners();
  }

  void updatePhoneNumber(String data) {
    _phoneNumber = data;
    notifyListeners();
  }

  void updateNationality(String data) {
    _nationality = data;
    notifyListeners();
  }

  void updateMainRoute(bool data) {
    _mainRoute = data;
    notifyListeners();
  }

  void updateSecondRoute(bool data) {
    _secondRoute = data;
    notifyListeners();
  }
}
