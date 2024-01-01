import 'package:flutter/material.dart';

Future<T?> skBottomSheet<T>(
  BuildContext context,
  Widget child, {
  EdgeInsets? padding,
  double? height,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    backgroundColor: Theme.of(context).cardColor,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * (height ?? 0.6),
    ),
    builder: (context) => Container(
      padding: padding ?? const EdgeInsets.all(20),
      child: SafeArea(child: child),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
  );
}
