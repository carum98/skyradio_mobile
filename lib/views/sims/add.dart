import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
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
      ),
      floatingActionButton: SkButton(
        text: 'Guardar',
        onPressed: () {
          final radiosRepository = DI.of(context).radiosRepository;

          radiosRepository.addSim(widget.radio.code, {
            'sim_code': item!.code,
          }).then((_) {
            Navigator.pop(context, true);
          });
        },
      ),
    );
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
