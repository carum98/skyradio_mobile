import 'package:flutter/material.dart';

class BasicTile extends StatelessWidget {
  final String title;
  final Color? color;

  const BasicTile({
    super.key,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      child: Row(
        children: [
          if (color != null) ...[
            Icon(
              Icons.circle,
              size: 15,
              color: color,
            ),
            const SizedBox(width: 10),
          ],
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
