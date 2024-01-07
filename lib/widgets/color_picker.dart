import 'dart:math';

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

class SkColorPicker extends StatefulWidget {
  final Color? initialColor;
  final Function(Color) onChanged;
  final bool isRequired;

  const SkColorPicker({
    super.key,
    this.initialColor,
    required this.onChanged,
    this.isRequired = false,
  });

  static Widget label({
    required String label,
    final Color? initialColor,
    required final Function(Color) onChanged,
    bool? isRequired,
  }) {
    return SkLabel(
      label: label,
      child: SkColorPicker(
        initialColor: initialColor,
        onChanged: onChanged,
        isRequired: isRequired ?? false,
      ),
    );
  }

  @override
  State<SkColorPicker> createState() => _SkColorPickerState();
}

class _SkColorPickerState extends State<SkColorPicker> {
  Color? _color;

  @override
  void initState() {
    super.initState();

    _color = widget.initialColor ??
        _colors.elementAt(Random().nextInt(_colors.length));

    if (widget.isRequired) {
      Future.delayed(Duration.zero, () {
        widget.onChanged.call(_color!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _colors
          .map(
            (color) => GestureDetector(
              onTap: () {
                widget.onChanged.call(color);
                setState(() => _color = color);
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                child: color == _color
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            ),
          )
          .toList(),
    );
  }
}
