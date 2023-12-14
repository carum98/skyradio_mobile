import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class RadiosView extends StatelessWidget {
  const RadiosView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).radiosRepository.getRadios;

    return SkScaffold(
      title: 'Radios',
      provider: provider,
      builder: (radio) => _Tile(radio: radio),
    );
  }
}

class _Tile extends StatelessWidget {
  final Radios radio;

  const _Tile({
    required this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(radio.imei),
      trailing: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              size: 14,
              color: radio.model.color,
            ),
            const SizedBox(width: 5),
            Text(
              radio.model.name,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
