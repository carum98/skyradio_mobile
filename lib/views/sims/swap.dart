import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/sims.dart';

class SwapSimsView extends StatefulWidget {
  final Radios radio;
  final Sims sim;

  const SwapSimsView({
    super.key,
    required this.radio,
    required this.sim,
  });

  @override
  State<SwapSimsView> createState() => _SwapSimViewState();
}

class _SwapSimViewState extends State<SwapSimsView> {
  Sims? itemTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SimsFormTile(sim: widget.sim),
          const SizedBox(height: 15),
          const RotatedBox(
            quarterTurns: 1,
            child: SkIcon(SkIconData.arrows, size: 40),
          ),
          const SizedBox(height: 15),
          if (itemTo == null)
            PickerSkeleton(
              title: 'Seleccionar SIM',
              onPressed: _pickSimTo,
            )
          else
            SimsFormTile(sim: itemTo!),
        ],
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: itemTo != null ? Offset.zero : const Offset(0, 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SkButton(
              onPressed: _onSend,
              text: 'Guardar',
            ),
          ],
        ),
      ),
    );
  }

  void _onSend() {
    final radiosRepository = DI.of(context).radiosRepository;

    radiosRepository.swapSim(widget.radio.code, {
      'sim_code': itemTo!.code,
    }).then((_) {
      Navigator.pop(context, true);
    });
  }

  void _pickSimTo() async {
    final sim = await Navigator.of(context).pushNamed(
      SIMS_SELECTOR_VIEW,
      arguments: {
        'clients[code][is_null]': '',
        'sims[code][not_equal]': widget.sim.code,
      },
    ) as Sims?;

    if (sim != null) {
      setState(() {
        itemTo = sim;
      });
    }
  }
}
