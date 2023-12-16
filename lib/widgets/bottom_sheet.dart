import 'package:flutter/material.dart';

Future<T?> skBottomSheet<T>(BuildContext context, Widget child) async {
  return await showModalBottomSheet<T>(
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(20),
      child: child,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
  );
}
