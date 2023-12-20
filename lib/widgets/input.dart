import 'package:flutter/material.dart';
import 'package:skyradio_mobile/widgets/label.dart';

class SkInput extends StatefulWidget {
  final String placeholder;
  final String? initialValue;
  final Function(String) onChanged;

  const SkInput({
    super.key,
    this.initialValue,
    required this.placeholder,
    required this.onChanged,
  });

  static Widget label({
    required String label,
    required String placeholder,
    required Function(String) onChanged,
    String? initialValue,
  }) {
    return SkLabel(
      label: label,
      child: SkInput(
        placeholder: placeholder,
        initialValue: initialValue,
        onChanged: onChanged,
      ),
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
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.placeholder,
        ),
      ),
    );
  }
}
