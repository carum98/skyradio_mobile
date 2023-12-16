import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/badget.dart';

class RadioView extends StatelessWidget {
  final Radios radio;

  const RadioView({
    super.key,
    required this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                radio.imei,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Nombre: ${radio.name}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Modelo: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SkBadge(
                    label: radio.model.name,
                    color: radio.model.color,
                  ),
                ],
              ),
              if (radio.serial != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Serial: ${radio.serial}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
              if (radio.sim != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'SIM: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    SkBadge(
                      label: radio.sim!.number,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Proveedor: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    SkBadge(
                      label: radio.sim!.provider.name,
                      color: radio.sim!.provider.color,
                    ),
                  ],
                )
              ]
            ],
          ),
        ),
      ],
    );
  }
}
