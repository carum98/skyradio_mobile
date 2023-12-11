import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }
}
