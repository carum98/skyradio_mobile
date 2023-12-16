import 'package:flutter/material.dart';

class SkInput extends StatelessWidget {
  final String placeholder;
  final Function(String) onChanged;

  const SkInput({
    super.key,
    required this.placeholder,
    required this.onChanged,
  });

  static Widget label({
    required String label,
    required String placeholder,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
        SkInput(
          placeholder: placeholder,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.grey,
      ),
    );

    return TextFormField(
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        focusedBorder: border.copyWith(
          borderSide: border.borderSide.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: border,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
