import 'package:flutter/material.dart';

class SkLogo extends StatelessWidget {
  final int size;

  const SkLogo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 10,
          )
        ],
      ),
      child: Image.asset(
        'assets/logo.png',
        width: size.toDouble(),
      ),
    );
  }
}
