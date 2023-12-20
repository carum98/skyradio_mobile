import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/color_picker.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class ClientsFormView extends StatelessWidget {
  const ClientsFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = ClientsForm();

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
              placeholder: 'Nombre del cliente',
              onChanged: (value) {
                form.name = value;
              },
            ),
            SkSelect.label(
              label: 'Modalidad',
              placeholder: 'Modalidad',
              provider: DI.of(context).commonRepository.getModalities,
              itemBuilder: (item) => BasicTile(
                title: item.name,
                color: item.color,
              ),
              onChanged: (value) {
                form.modality = value;
              },
            ),
            SkSelect.label(
              label: 'Vendedor',
              placeholder: 'Vendedor',
              provider: DI.of(context).commonRepository.getSellers,
              itemBuilder: (item) => BasicTile(title: item.name),
              onChanged: (value) {
                form.seller = value;
              },
            ),
            SkColorPicker.label(
              label: 'Color',
              initialColor: form.color,
              onChanged: (value) {
                form.color = value;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SkButton(
        onPressed: () {
          print(form.toRequestData());
        },
        text: 'Guardar',
      ),
    );
  }
}
