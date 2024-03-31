import 'package:flutter/material.dart';
import 'package:skyradio_mobile/widgets/label.dart';

class SkInput extends StatefulWidget {
  final String placeholder;
  final String? initialValue;
  final bool? autofocus;
  final bool? obscureText;
  final bool isRequired;
  final int? maxLength;
  final int? minLength;
  final int? length;
  final Function(String) onChanged;

  const SkInput({
    super.key,
    this.initialValue,
    this.autofocus,
    this.obscureText,
    required this.placeholder,
    required this.onChanged,
    this.isRequired = false,
    this.maxLength,
    this.minLength,
    this.length,
  });

  static Widget label({
    required String label,
    required String placeholder,
    required Function(String) onChanged,
    String? initialValue,
    bool? autofocus,
    bool? obscureText,
    bool? isRequired,
    int? maxLength,
    int? minLength,
    int? length,
  }) {
    return SkLabel(
      label: label,
      isRequired: isRequired,
      child: SkInput(
        placeholder: placeholder,
        initialValue: initialValue,
        autofocus: autofocus,
        obscureText: obscureText,
        onChanged: onChanged,
        isRequired: isRequired ?? false,
        maxLength: maxLength,
        minLength: minLength,
        length: length,
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
        autofocus: widget.autofocus ?? false,
        focusNode: focusNode,
        initialValue: widget.initialValue,
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength ?? widget.length,
        validator: validator,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          counterText: '',
        ),
      ),
    );
  }

  String? validator(String? value) {
    if (widget.isRequired) {
      if (value == null || value.isEmpty) {
        return 'Este campo es requerido';
      }
    }

    if (widget.minLength != null) {
      if (value!.length < widget.minLength!) {
        return 'Este campo debe tener al menos ${widget.minLength} caracteres';
      }
    }

    if (widget.maxLength != null) {
      if (value!.length > widget.maxLength!) {
        return 'Este campo debe tener como maximo ${widget.maxLength} caracteres';
      }
    }

    if (widget.length != null) {
      if (value!.length != widget.length!) {
        return 'Este campo debe tener ${widget.length} caracteres';
      }
    }

    return null;
  }
}
