import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/color_picker.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class ClientsFormView extends StatelessWidget {
  final ClientsForm model;

  const ClientsFormView({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return SkScaffoldForm(
      model: model,
      onSend: (params) {
        if (model.isEditing) {
          print('update: $params');
        } else {
          print('create: $params');
        }
      },
      builder: (model) => [
        SkInput.label(
          label: 'Nombre',
          placeholder: 'Nombre del cliente',
          initialValue: model.name,
          onChanged: (value) {
            model.name = value;
          },
        ),
        SkSelect.label(
          label: 'Modalidad',
          placeholder: 'Modalidad',
          provider: DI.of(context).commonRepository.getModalities,
          initialValue: model.modality,
          itemBuilder: (item) => BasicTile(
            title: item.name,
            color: item.color,
          ),
          onChanged: (value) {
            model.modality = value;
          },
        ),
        SkSelect.label(
          label: 'Vendedor',
          placeholder: 'Vendedor',
          provider: DI.of(context).commonRepository.getSellers,
          itemBuilder: (item) => BasicTile(title: item.name),
          initialValue: model.seller,
          onChanged: (value) {
            model.seller = value;
          },
        ),
        SkColorPicker.label(
          label: 'Color',
          initialColor: model.color,
          onChanged: (value) {
            model.color = value;
          },
        ),
      ],
    );
  }
}
