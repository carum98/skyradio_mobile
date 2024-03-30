import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/apps.dart';

class AppsTile extends StatelessWidget {
  final Apps app;

  const AppsTile({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.name),
    );
  }
}
