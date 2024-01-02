import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/badget.dart';

class RadioView extends StatelessWidget {
  final ValueNotifier<Radios> radio;

  RadioView({
    super.key,
    required Radios radio,
  }) : radio = ValueNotifier(radio);

  @override
  Widget build(BuildContext context) {
    bool wasEdited = false;

    void onRefreshRadio() {
      DI
          .of(context)
          .radiosRepository
          .getRadio(radio.value.code)
          .then((value) => radio.value = value);
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
          ListenableBuilder(
            listenable: radio,
            builder: (_, __) {
              return Column(
                mainAxisSize: MainAxisSize.min,
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
                          radio.value.imei,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Nombre: ${radio.value.name}',
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
                              label: radio.value.model.name,
                              color: radio.value.model.color,
                            ),
                          ],
                        ),
                        if (radio.value.serial != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            'Serial: ${radio.value.serial}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                        if (radio.value.sim != null) ...[
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'SIM: ',
                                style: TextStyle(fontSize: 16),
                              ),
                              SkBadge(
                                label: radio.value.sim!.number,
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
                                label: radio.value.sim!.provider.name,
                                color: radio.value.sim!.provider.color,
                              ),
                            ],
                          )
                        ]
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                SkBottomSheet.of(context).pushNamed(
                  RADIOS_ACTIONS_BOTTOM_SHEET,
                  arguments: {
                    'radio': radio.value,
                    'onRefresh': () {
                      wasEdited = true;
                      onRefreshRadio();
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
