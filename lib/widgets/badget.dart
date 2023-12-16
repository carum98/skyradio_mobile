import 'package:flutter/material.dart';

class SkBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const SkBadge({
    super.key,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (color != null)
            Icon(
              Icons.circle,
              size: 14,
              color: color,
            ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
