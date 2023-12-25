import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class RemoveSimsView extends StatelessWidget {
  final Radios? radio;
  final Sims? sim;

  const RemoveSimsView({
    super.key,
    required this.radio,
    required this.sim,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SkIcon(
          SkIconData.arrow_up,
          size: 50,
          color: Colors.red,
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: '¿Desvincular ',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 22),
            children: const [
              TextSpan(
                text: 'SIM',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '?'),
            ],
          ),
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
              onPressed: () async {
                final radiosRepository = DI.of(context).radiosRepository;
                final simsRepository = DI.of(context).simsRepository;

                if (radio != null) {
                  await radiosRepository.removeSim(radio!.code);
                } else if (sim != null) {
                  await simsRepository.removeRadio(sim!.code);
                }

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
