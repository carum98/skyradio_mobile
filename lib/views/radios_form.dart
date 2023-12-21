import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class RadiosFormView extends StatelessWidget {
  final RadiosForm model;

  const RadiosFormView({
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
      builder: (value) => [
        SkInput.label(
          label: 'Nombre',
          placeholder: 'Nombre del radio',
          initialValue: model.name,
          onChanged: (value) {
            model.name = value;
          },
        ),
        SkInput.label(
          label: 'IMEI',
          placeholder: 'IMEI',
          initialValue: model.imei,
          onChanged: (value) {
            model.imei = value;
          },
        ),
        SkInput.label(
          label: 'Serial',
          placeholder: 'Serial',
          initialValue: model.serial,
          onChanged: (value) {
            model.serial = value;
          },
        ),
        SkSelect.label(
          label: 'Modelo',
          placeholder: 'Modelo',
          provider: DI.of(context).commonRepository.getModels,
          initialValue: model.model,
          itemBuilder: (item) => BasicTile(
            title: item.name,
            color: item.color,
          ),
          onChanged: (value) {
            model.model = value;
          },
        ),
      ],
    );
  }
}
