import 'package:flutter/material.dart';

Future<T?> skBottomSheet<T>(BuildContext context, Widget child) async {
  return await showModalBottomSheet<T>(
    context: context,
    backgroundColor: Theme.of(context).cardColor,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.5,
    ),
    builder: (context) => Container(
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
