import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void setAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }
}
