import 'package:flutter/material.dart';

class SkLabel extends StatelessWidget {
  final String label;
  final Widget child;

  const SkLabel({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
        child,
      ],
    );
  }
}
