import 'package:flutter/material.dart';

class SkLabel extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;

  const SkLabel({
    super.key,
    required this.label,
    required this.child,
    bool? isRequired,
  }) : isRequired = isRequired ?? false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              text: label,
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
