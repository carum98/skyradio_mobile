import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/badget.dart';

class SimView extends StatelessWidget {
  final Sims sim;

  const SimView({
    super.key,
    required this.sim,
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
                sim.number,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Proveedor: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SkBadge(
                    label: sim.provider.name,
                    color: sim.provider.color,
                  ),
                ],
              ),
              if (sim.serial != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Serial: ${sim.serial}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
              if (sim.radio != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Radio: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    SkBadge(
                      label: sim.radio!.imei,
                    ),
                  ],
                ),
              ],
              if (sim.radio?.client != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Cliente: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    SkBadge(
                      label: sim.radio!.client!.name,
                      color: sim.radio!.client!.color,
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
