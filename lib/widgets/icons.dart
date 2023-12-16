// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum SkIconData {
  arrow_down,
  arrow_up,
  arrows,
  filter,
  sort,
}

class SkIcon extends StatelessWidget {
  final SkIconData icon;
  final Color color;
  final int size;

  const SkIcon(
    this.icon, {
    super.key,
    this.color = Colors.white,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/${icon.name}.svg',
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      height: size.toDouble(),
      width: size.toDouble(),
    );
  }
}
