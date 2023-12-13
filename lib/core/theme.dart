import 'package:flutter/material.dart';

const _primaryColorDark = Color(0xFF014b9b);
const _backgroundColorDark = Color(0xFF1e2023);
const _containerColorDark = Color(0xFF121212);

const _primaryColorLight = Color(0xFF0160be);
const _backgroundColorLight = Color(0xFFf2f5fc);
const _containerColorLight = Color(0xFFffffff);

class SkTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColorLight,
      background: _backgroundColorLight,
    ),
    cardColor: _containerColorLight,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColorDark,
      brightness: Brightness.dark,
      background: _backgroundColorDark,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryColorDark,
      iconSize: 35,
    ),
    cardColor: _containerColorDark,
  );
}
