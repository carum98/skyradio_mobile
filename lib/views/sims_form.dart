import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class SimsFormView extends StatelessWidget {
  const SimsFormView({super.key});

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
              label: 'Numero',
              placeholder: 'Numero de sim',
              onChanged: (value) {},
            ),
            SkInput.label(
              label: 'Serial',
              placeholder: 'Serial',
              onChanged: (value) {},
            ),
            SkSelect.label(
              label: 'Proveedor',
              placeholder: 'Proveedor',
              provider: DI.of(context).commonRepository.getProviders,
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
