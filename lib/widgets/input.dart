import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
import 'package:skyradio_mobile/widgets/label.dart';

class SkInput extends StatefulWidget {
  final String placeholder;
  final String? initialValue;
  final bool? autofocus;
  final bool? obscureText;
  final bool scanner;
  final bool isRequired;
  final int? maxLength;
  final int? minLength;
  final int? length;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;

  const SkInput({
    super.key,
    this.initialValue,
    this.autofocus,
    this.obscureText,
    required this.placeholder,
    required this.onChanged,
    this.scanner = false,
    this.isRequired = false,
    this.maxLength,
    this.minLength,
    this.length,
    this.keyboardType,
  });

  static Widget label({
    required String label,
    required String placeholder,
    required Function(String) onChanged,
    String? initialValue,
    bool? autofocus,
    bool? obscureText,
    bool? scanner,
    bool? isRequired,
    int? maxLength,
    int? minLength,
    int? length,
    TextInputType? keyboardType,
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
        scanner: scanner ?? false,
        maxLength: maxLength,
        minLength: minLength,
        length: length,
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  State<SkInput> createState() => _SkInputState();
}

class _SkInputState extends State<SkInput> {
  late final FocusNode focusNode;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.initialValue,
    );

    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
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
        controller: controller,
        autofocus: widget.autofocus ?? false,
        focusNode: focusNode,
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength ?? widget.length,
        validator: validator,
        keyboardType: widget.keyboardType,
        keyboardAppearance: Brightness.dark,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          counterText: '',
          suffixIcon: widget.scanner
              ? _ButtonScanner(
                  onChanged: (value) {
                    controller.text = value;
                    widget.onChanged(value);
                  },
                )
              : null,
        ),
      ),
    );
  }

  String? validator(String? value) {
    if (widget.isRequired) {
      if (value == null || value.isEmpty) {
        return 'Este campo es requerido';
      }
    } else {
      if (value == null || value.isEmpty) {
        return null;
      }
    }

    if (widget.minLength != null) {
      if (value.length < widget.minLength!) {
        return 'Este campo debe tener al menos ${widget.minLength} caracteres';
      }
    }

    if (widget.maxLength != null) {
      if (value.length > widget.maxLength!) {
        return 'Este campo debe tener como maximo ${widget.maxLength} caracteres';
      }
    }

    if (widget.length != null) {
      if (value.length != widget.length!) {
        return 'Este campo debe tener ${widget.length} caracteres';
      }
    }

    return null;
  }
}

class _ButtonScanner extends StatelessWidget {
  final void Function(String) onChanged;

  const _ButtonScanner({
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const SkIcon(SkIconData.bar_code, color: Colors.grey),
      padding: const EdgeInsets.only(right: 15),
      onPressed: () async {
        final value = await SkBottomSheet.of(context).pushNamed<String?>(
          SCAN_CODE,
          padding: EdgeInsets.zero,
        );

        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
