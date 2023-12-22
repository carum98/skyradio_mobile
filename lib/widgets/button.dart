import 'package:flutter/material.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class SkButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final SkIconData? icon;
  final Color? backgroundColor;
  final bool textLeft;

  const SkButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textLeft = false,
  });

  static Widget block({
    required void Function() onPressed,
    required String text,
    SkIconData? icon,
    Color? backgroundColor,
    bool textLeft = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: SkButton(
        onPressed: onPressed,
        text: text,
        icon: icon,
        backgroundColor: backgroundColor,
        textLeft: textLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainAxisSize =
        context.findAncestorWidgetOfExactType<SizedBox>() != null
            ? MainAxisSize.max
            : MainAxisSize.min;

    final mainAxisAlignment =
        textLeft ? MainAxisAlignment.start : MainAxisAlignment.center;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
      ),
      child: Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (icon != null) ...[
            SkIcon(
              icon!,
              size: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 15),
          ],
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
