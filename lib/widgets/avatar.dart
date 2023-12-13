import 'package:flutter/material.dart';

class SkAvatar extends StatelessWidget {
  final Color color;
  final String initials;

  SkAvatar({
    super.key,
    required this.color,
    required String alt,
  }) : initials = alt.substring(0, 2).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
