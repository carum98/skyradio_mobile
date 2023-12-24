import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/selectors/sims.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';

class AddRadiosView extends StatefulWidget {
  final Clients client;

  const AddRadiosView({
    super.key,
    required this.client,
  });

  @override
  State<AddRadiosView> createState() => _AddRadiosViewState();
}

class _AddRadiosViewState extends State<AddRadiosView> {
  final List<RadiosItemForm> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (_, index) => _Tile(item: items[index]),
            ),
            PickerSkeleton(
              title: 'Seleccionar Radio',
              onPressed: () async {
                final radio = await Navigator.of(context).pushNamed(
                  RADIOS_SELECTOR_VIEW,
                  arguments: items.map((e) => e.radio).toList(),
                ) as Radios?;

                if (radio != null) {
                  setState(() {
                    items.add(RadiosItemForm(radio: radio));
                  });
                }
              },
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
}

class _Tile extends StatelessWidget {
  final RadiosItemForm item;

  const _Tile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 15,
              right: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SkInput(
                    placeholder: 'Nombre',
                    initialValue: item.name,
                    onChanged: (value) {
                      item.name = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 130,
                  child: SimsSelector(
                    initialValue: item.sim,
                    onChanged: (value) {
                      item.sim = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          RadiosTile(radio: item.radio),
        ],
      ),
    );
  }
}
