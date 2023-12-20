import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class RadiosFormView extends StatelessWidget {
  const RadiosFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Wrap(
          runSpacing: 20,
          children: [
            SkInput.label(
              label: 'Nombre',
              placeholder: 'Nombre del radio',
              onChanged: (value) {},
            ),
            SkInput.label(
              label: 'IMEI',
              placeholder: 'IMEI',
              onChanged: (value) {},
            ),
            SkInput.label(
              label: 'Serial',
              placeholder: 'Serial',
              onChanged: (value) {},
            ),
            SkSelect.label(
              label: 'Modelo',
              placeholder: 'Modelo',
              provider: DI.of(context).commonRepository.getModels,
              itemBuilder: (item) => BasicTile(
                title: item.name,
                color: item.color,
              ),
              onChanged: (value) {},
            )
          ],
        ),
      ),
      floatingActionButton: SkButton(
        onPressed: () {},
        text: 'Guardar',
      ),
    );
  }
}
