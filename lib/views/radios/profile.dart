import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_profile.dart';

class RadioView extends StatelessWidget {
  final Radios radio;

  const RadioView({
    super.key,
    required this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return SkScaffoldProfile(
      item: radio,
      title: radio.imei,
      onActions: (value, callback) {
        SkBottomSheet.of(context).pushNamed(
          RADIOS_ACTIONS_BOTTOM_SHEET,
          arguments: {
            'radio': value,
            'onRefresh': () async {
              final radio =
                  await DI.of(context).radiosRepository.getRadio(value.code);
              callback(radio);
            },
          },
        );
      },
      builder: (value) => [
        if (value.name != null)
          Text(
            'Nombre: ${value.name}',
            style: const TextStyle(fontSize: 16),
          ),
        Row(
          children: [
            const Text(
              'Modelo: ',
              style: TextStyle(fontSize: 16),
            ),
            SkBadge(
              label: value.model.name,
              color: value.model.color,
            ),
          ],
        ),
        if (value.serial != null)
          Text(
            'Serial: ${value.serial}',
            style: const TextStyle(fontSize: 16),
          ),
        if (value.sim != null) ...[
          Row(
            children: [
              const Text(
                'SIM: ',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: value.sim!.number,
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Proveedor: ',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: value.sim!.provider.name,
                color: value.sim!.provider.color,
              ),
            ],
          )
        ]
      ],
    );
  }
}
