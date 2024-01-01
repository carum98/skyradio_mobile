import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

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
          child: _RadioActions(radio: radio),
        ),
      ],
    );
  }
}

class _RadioActions extends StatelessWidget {
  final Radios radio;

  const _RadioActions({required this.radio});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 10, 74, 155),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.more_vert),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      offset: const Offset(0, 40),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            Navigator.of(context)
                .pushNamed(RADIOS_UPDATE_VIEW, arguments: radio)
                .then((value) => {if (value == true) () {}});
            break;
          case 'delete':
            SkDialog.of(context)
                .pushNamed(RADIOS_REMOVE_DIALOG, arguments: radio)
                .then((value) =>
                    {if (value == true) Navigator.of(context).pop()});
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'edit',
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SkIcon(SkIconData.update, size: 20),
              SizedBox(width: 10),
              Text('Actualizar', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SkIcon(SkIconData.trash, size: 20),
              SizedBox(width: 10),
              Text('Eliminar', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
