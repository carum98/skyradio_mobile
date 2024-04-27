import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_profile.dart';

class SimView extends StatelessWidget {
  final Sims sim;

  const SimView({
    super.key,
    required this.sim,
  });

  @override
  Widget build(BuildContext context) {
    final user = DI.of(context).state.user;

    return SkScaffoldProfile(
      item: sim,
      title: sim.number,
      onActions: (value, callback) {
        if (user.isAdmin || user.isUser) {
          SkBottomSheet.of(context).pushNamed(
            SIMS_ACTIONS_BOTTOM_SHEET,
            arguments: {
              'sim': value,
              'onRefresh': () async {
                final sim =
                    await DI.of(context).simsRepository.getSim(value.code);
                callback(sim);
              },
            },
          );
        }
      },
      builder: (value) => [
        Row(
          children: [
            const Text(
              'Proveedor: ',
              style: TextStyle(fontSize: 16),
            ),
            SkBadge(
              label: value.provider.name,
              color: value.provider.color,
            ),
          ],
        ),
        if (value.serial != null)
          Text(
            'Serial: ${value.serial}',
            style: const TextStyle(fontSize: 16),
          ),
        if (value.radio != null)
          Row(
            children: [
              const Text(
                'Radio: ',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: value.radio!.imei,
              ),
            ],
          ),
        if (value.radio?.client != null)
          Row(
            children: [
              const Text(
                'Cliente: ',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: value.radio!.client!.name,
                color: value.radio!.client!.color,
              ),
            ],
          ),
      ],
    );
  }
}
