import 'package:flutter/material.dart';
import 'package:skyradio_mobile/utils/color.dart';

const _primaryColorDark = Color(0xFF014b9b);
const _backgroundColorDark = Color(0xFF1e2023);
const _containerColorDark = Color(0xFF121212);

const _primaryColorLight = Color(0xFF0160be);
const _backgroundColorLight = Color(0xFFf2f5fc);
const _containerColorLight = Color(0xFFffffff);

final _elevatedButton = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  elevation: 0,
  padding: const EdgeInsets.all(0),
  backgroundColor: _containerColorDark,
);

const _floatingActionButton = FloatingActionButtonThemeData(
  iconSize: 35,
);

const _inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  borderSide: BorderSide(
    width: 1.3,
    color: Color.fromRGBO(177, 177, 177, 1),
  ),
);

const _inputDecoration = InputDecorationTheme(
  filled: true,
  enabledBorder: _inputBorder,
  focusedBorder: _inputBorder,
  contentPadding: EdgeInsets.symmetric(
    vertical: 18,
    horizontal: 25,
  ),
);

class SkTheme {
  static final light = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: _primaryColorLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColorLight,
      background: _backgroundColorLight,
    ),
    cardColor: _containerColorLight,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _elevatedButton.copyWith(
        backgroundColor: _containerColorLight.toMaterialStateProperty(),
      ),
    ),
    floatingActionButtonTheme: _floatingActionButton.copyWith(
      backgroundColor: _primaryColorLight,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: _inputDecoration.copyWith(
      fillColor: _containerColorLight,
      focusedBorder: _inputBorder.copyWith(
        borderSide: _inputBorder.borderSide.copyWith(color: _primaryColorLight),
      ),
    ),
  );

  static final dark = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: _primaryColorDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColorDark,
      brightness: Brightness.dark,
      background: _backgroundColorDark,
    ),
    cardColor: _containerColorDark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _elevatedButton.copyWith(
        backgroundColor: _containerColorDark.toMaterialStateProperty(),
      ),
    ),
    floatingActionButtonTheme: _floatingActionButton.copyWith(
      backgroundColor: _primaryColorDark,
    ),
    inputDecorationTheme: _inputDecoration.copyWith(
      fillColor: _containerColorDark,
      focusedBorder: _inputBorder.copyWith(
        borderSide: _inputBorder.borderSide.copyWith(color: _primaryColorDark),
      ),
    ),
  );
}
