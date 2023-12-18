import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class ClientsFormView extends StatelessWidget {
  const ClientsFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Form(
          child: Wrap(
            runSpacing: 20,
            children: [
              SkInput.label(
                label: 'Nombre',
                placeholder: 'Nombre del cliente',
                onChanged: (v) {},
              ),
              SkSelect.label(
                label: 'Modalidad',
                placeholder: 'Modalidad del cliente',
                provider: DI.of(context).commonRepository.getModalities,
                onChanged: (v) {},
                itemBuilder: (item) => BasicTile(
                  title: item.name,
                  color: item.color,
                ),
              ),
              SkSelect.label(
                label: 'Vendedor',
                placeholder: 'Vendedor del cliente',
                provider: DI.of(context).commonRepository.getSellers,
                onChanged: (v) {},
                itemBuilder: (item) => BasicTile(title: item.name),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SkButton(
        onPressed: () {},
        text: 'Actualizar',
      ),
    );
  }
}
