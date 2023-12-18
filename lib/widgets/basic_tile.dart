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
    return ListTile(
      leading: color != null
          ? Icon(
              Icons.circle,
              size: 14,
              color: color,
            )
          : null,
      minLeadingWidth: 0,
      title: Text(title),
    );
  }
}
