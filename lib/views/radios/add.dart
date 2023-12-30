import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';

class AddRadiosView extends StatefulWidget {
  final Clients client;
  final Radios? radio;

  const AddRadiosView({
    super.key,
    required this.client,
    this.radio,
  });

  @override
  State<AddRadiosView> createState() => _AddRadiosViewState();
}

class _AddRadiosViewState extends State<AddRadiosView> {
  final List<RadiosItemForm> items = [];

  @override
  void initState() {
    super.initState();

    if (widget.radio != null) {
      items.add(RadiosItemForm(radio: widget.radio!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (_, index) => RadiosFormTile(item: items[index]),
            ),
            const SizedBox(height: 20),
            PickerSkeleton(
              title: 'Seleccionar Radio',
              onPressed: _pickRadio,
            ),
          ],
        ),
      ),
      floatingActionButton: SkButton(
        text: 'Guardar',
        onPressed: () {
          final clientsRepository = DI.of(context).clientsRepository;
          final radiosRepository = DI.of(context).radiosRepository;

          final addRadios = clientsRepository.addRadio(widget.client.code, {
            'radios_codes': items.map((e) => e.radio.code).toList(),
          });

          final updateRadios = items
              .map((e) => radiosRepository.update(e.radio.code, e.getParams()))
              .toList();

          Future.wait([addRadios, ...updateRadios]).then((value) {
            Navigator.pop(context, true);
          });
        },
      ),
    );
  }

  void _pickRadio() async {
    final radio = await Navigator.of(context).pushNamed(
      RADIOS_SELECTOR_VIEW,
      arguments: {
        'clients[code][is_null]': '',
        if (items.isNotEmpty)
          'radios[code][not_in]': items.map((e) => e.radio.code).join(','),
      },
    ) as Radios?;

    if (radio != null) {
      setState(() {
        items.add(RadiosItemForm(radio: radio));
      });
    }
  }
}

class AddRadioView extends StatefulWidget {
  final Sims sim;

  const AddRadioView({
    super.key,
    required this.sim,
  });

  @override
  State<AddRadioView> createState() => _AddRadioViewState();
}

class _AddRadioViewState extends State<AddRadioView> {
  Radios? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          if (item != null)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: RadiosTile(radio: item!),
              ),
            )
          else
            PickerSkeleton(
              title: 'Seleccionar Radio',
              onPressed: _pickRadio,
            ),
        ],
      ),
      floatingActionButton: SkButton(
        text: 'Guardar',
        onPressed: () {
          final simsRepository = DI.of(context).simsRepository;

          simsRepository.addRadio(widget.sim.code, {
            'radio_code': item!.code,
          }).then((_) {
            Navigator.pop(context, true);
          });
        },
      ),
    );
  }

  void _pickRadio() async {
    final radio = await Navigator.of(context).pushNamed(
      RADIOS_SELECTOR_VIEW,
      arguments: {
        'clients[code][is_null]': '',
        if (item != null) 'radios[code][not_equal]': item!.code,
      },
    ) as Radios?;

    if (radio != null) {
      setState(() {
        item = radio;
      });
    }
  }
}
