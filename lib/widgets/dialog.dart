import 'dart:ui';

import 'package:flutter/material.dart';

Future<T?> skDialog<T>(BuildContext context, Widget child) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: child,
        ),
      ),
    ),
  );
}
