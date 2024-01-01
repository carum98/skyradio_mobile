import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
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
    return Stack(
      children: [
        Column(
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
        ),
        Positioned(
          top: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              SkBottomSheet.of(context).pushNamed(
                RADIOS_ACTIONS_BOTTOM_SHEET,
                arguments: {
                  'radio': radio,
                  'onRefresh': () {},
                },
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(35, 35),
              backgroundColor: const Color.fromARGB(150, 10, 74, 155),
            ),
            child: const Icon(Icons.more_vert, size: 25, color: Colors.white),
          ),
        )
      ],
    );
  }
}
