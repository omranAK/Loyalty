import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  String _phoneCode = '974';
  String _phoneNumber = '';
  String _nationality = 'Qatar';

  Locale _locale = const Locale('ar', 'SA');

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

  void updateLanguage(Locale locale) {
    _locale = locale;
    notifyListeners();
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
