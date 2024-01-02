import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/badget.dart';

class SimView extends StatelessWidget {
  final ValueNotifier<Sims> sim;

  SimView({
    super.key,
    required Sims sim,
  }) : sim = ValueNotifier(sim);

  @override
  Widget build(BuildContext context) {
    bool wasEdited = false;

    void onRefreshSim() {
      DI
          .of(context)
          .simsRepository
          .getSim(sim.value.code)
          .then((value) => sim.value = value);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop(wasEdited);
      },
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListenableBuilder(
                  listenable: sim,
                  builder: (_, __) {
                    return Container(
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
                            sim.value.number,
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
                                label: sim.value.provider.name,
                                color: sim.value.provider.color,
                              ),
                            ],
                          ),
                          if (sim.value.serial != null) ...[
                            const SizedBox(height: 10),
                            Text(
                              'Serial: ${sim.value.serial}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                          if (sim.value.radio != null) ...[
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Radio: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SkBadge(
                                  label: sim.value.radio!.imei,
                                ),
                              ],
                            ),
                          ],
                          if (sim.value.radio?.client != null) ...[
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Cliente: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SkBadge(
                                  label: sim.value.radio!.client!.name,
                                  color: sim.value.radio!.client!.color,
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    );
                  }),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                SkBottomSheet.of(context).pushNamed(
                  SIMS_ACTIONS_BOTTOM_SHEET,
                  arguments: {
                    'sim': sim.value,
                    'onRefresh': () {
                      wasEdited = true;
                      onRefreshSim();
                    },
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
      ),
    );
  }
}
