import 'package:flutter/material.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class RemoveScaffold extends StatelessWidget {
  final String instance;
  final String? customMessage;
  final Future<void> Function() onRemove;

  const RemoveScaffold({
    super.key,
    required this.instance,
    this.customMessage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SkIcon(
          SkIconData.trash,
          size: 50,
          color: Colors.red,
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: customMessage ?? '¿Desea eliminar el ',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 22),
            children: [
              TextSpan(
                text: instance,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '?'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              text: 'Cancelar',
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 10),
            SkButton(
              text: 'Aceptar',
              onPressed: () {
                onRemove().then((value) => Navigator.of(context).pop(true));
              },
            ),
          ],
        ),
      ],
    );
  }
}
