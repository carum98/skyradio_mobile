import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/sims.dart';

class AddSimsView extends StatefulWidget {
  final Radios radio;
  final Sims? sim;

  const AddSimsView({
    super.key,
    required this.radio,
    this.sim,
  });

  @override
  State<AddSimsView> createState() => _AddSimsViewState();
}

class _AddSimsViewState extends State<AddSimsView> {
  Sims? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          if (item != null)
            SimsFormTile(sim: item!)
          else
            PickerSkeleton(
              title: 'Seleccionar SIM',
              onPressed: _pickSim,
            ),
        ],
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: item != null ? Offset.zero : const Offset(0, 3),
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

  void _onSend() async {
    final radiosRepository = DI.of(context).radiosRepository;
    final toast = SkToast.of(context);

    try {
      await radiosRepository.addSim(widget.radio.code, {
        'sim_code': item!.code,
      });

      toast.success(
        title: 'Exito!!',
        message: 'SIM relacionado correctamente',
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      toast.error(
        title: 'Error!!',
        message: 'Ocurrio un error al relacionar el SIM',
      );
    }
  }

  void _pickSim() async {
    final sim = await Navigator.of(context).pushNamed(
      SIMS_SELECTOR_VIEW,
      arguments: {
        'clients[code][is_null]': '',
        if (item != null) 'sims[code][not_equal]': item!.code,
      },
    ) as Sims?;

    if (sim != null) {
      setState(() {
        item = sim;
      });
    }
  }
}
