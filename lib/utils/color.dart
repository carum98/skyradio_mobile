import 'package:flutter/material.dart';

extension ColorToMaterialStateProperty on Color {
  MaterialStateProperty<Color?> toMaterialStateProperty() {
    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return this;
      },
    );
  }
}

extension HexToColor on String {
  Color toColor() {
    assert(length == 6 || length == 7, 'Invalid color: $this');

    if (contains('#')) {
      return Color(int.parse('0xFF${substring(1)}'));
    }

    return Color(int.parse('0xFF$this'));
  }
}

extension ColorToHex on Color {
  String toHex() {
    return '#${value.toRadixString(16).substring(2)}';
  }
}
