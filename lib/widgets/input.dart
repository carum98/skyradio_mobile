import 'package:flutter/material.dart';

class SkInput extends StatefulWidget {
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
  State<SkInput> createState() => _SkInputState();
}

class _SkInputState extends State<SkInput> {
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]
            : null,
      ),
      child: TextFormField(
        focusNode: focusNode,
        onChanged: widget.onChanged,
        decoration: _inputDecoration.copyWith(
          hintText: widget.placeholder,
          fillColor: Theme.of(context).cardColor,
          focusedBorder: _border.copyWith(
            borderSide: _border.borderSide.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

const _border = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  borderSide: BorderSide(
    width: 1.3,
    color: Color.fromRGBO(177, 177, 177, 1),
  ),
);

const _inputDecoration = InputDecoration(
  filled: true,
  enabledBorder: _border,
  contentPadding: EdgeInsets.symmetric(
    vertical: 18,
    horizontal: 25,
  ),
);