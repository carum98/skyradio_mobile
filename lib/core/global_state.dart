import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/user.dart';

class GlobalState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  bool _showBottomBar = true;
  bool get showBottomBar => _showBottomBar;

  User _user = User.fake();
  User get user => _user;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  void setShowBottomBar(bool value) {
    _showBottomBar = value;
    notifyListeners();
  }

  void setUser(User value) {
    _user = value;
    notifyListeners();
  }
}
