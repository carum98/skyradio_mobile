import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  bool _showBottomBar = true;
  bool get showBottomBar => _showBottomBar;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  void setShowBottomBar(bool value) {
    _showBottomBar = value;
    notifyListeners();
  }
}
