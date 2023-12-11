import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/theme.dart';

import 'core/router.dart';

void main() {
  runApp(const MyApp(isAuth: false));
}

class MyApp extends StatelessWidget {
  final bool isAuth;

  const MyApp({
    super.key,
    required this.isAuth,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkyRadio',
      debugShowCheckedModeBanner: false,
      theme: SkTheme.light,
      darkTheme: SkTheme.dark,
      themeMode: ThemeMode.dark,
      initialRoute: isAuth ? CLIENTS_VIEW : LOGIN_VIEW,
      onGenerateRoute: RouterGenerator.generate,
    );
  }
}
