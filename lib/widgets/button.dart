import 'package:flutter/material.dart';

class SkButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const SkButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  static Widget block({
    required void Function() onPressed,
    required String text,
  }) {
    return SizedBox(
      width: double.infinity,
      child: SkButton(
        onPressed: onPressed,
        text: text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
