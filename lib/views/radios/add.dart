import 'dart:ui';

import 'package:flutter/material.dart';
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
  final List<Radios> radios = [];

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (radios.isNotEmpty)
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: radios.length,
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (_, index) => _Tile(radio: radios[index]),
              ),
            PickerSkeleton(
              title: 'Seleccionar Radio',
              onPressed: () async {
                final radio = await Navigator.of(context).pushNamed(
                  RADIOS_SELECTOR_VIEW,
                  arguments: radios,
                ) as Radios?;

                if (radio != null) {
                  setState(() {
                    radios.add(radio);
                  });
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SkButton(
        text: 'Guardar',
        onPressed: () {},
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final Radios radio;

  const _Tile({required this.radio});

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
                    initialValue: radio.name,
                    onChanged: (v) {},
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 130,
                  child: SimsSelector(
                    initialValue: radio.sim,
                    onChanged: (v) {},
                  ),
                ),
              ],
            ),
          ),
          RadiosTile(radio: radio),
        ],
      ),
    );
  }
}
