import 'package:flutter/material.dart';
import 'package:skyradio_mobile/utils/color.dart';

import 'label.dart';

final _colors = [
  '#FF0000'.toColor(),
  '#FF7F00'.toColor(),
  '#FFFF00'.toColor(),
  '#00FF00'.toColor(),
  '#0000FF'.toColor(),
  '#4B0082'.toColor(),
  '#9400D3'.toColor(),
  '#FF00FF'.toColor(),
  '#FFC0CB'.toColor(),
  '#FFA500'.toColor(),
  '#A52A2A'.toColor(),
  '#800000'.toColor(),
  '#808000'.toColor(),
  '#008000'.toColor(),
  '#000080'.toColor(),
];

class SkColorPicker extends StatelessWidget {
  final Color? initialColor;

  const SkColorPicker({
    super.key,
    this.initialColor,
  });

  static Widget label({
    required String label,
    final Color? initialColor,
  }) {
    return SkLabel(
      label: label,
      child: SkColorPicker(
        initialColor: initialColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _colors
          .map(
            (color) => GestureDetector(
              onTap: () => Navigator.of(context).pop(color),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: color,
                ),
                child: color == initialColor
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            ),
          )
          .toList(),
    );
  }
}
