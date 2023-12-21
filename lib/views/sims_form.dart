import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class SimsFormView extends StatelessWidget {
  final SimsForm model;

  const SimsFormView({
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
          label: 'Numero',
          placeholder: 'Numero de sim',
          initialValue: model.number,
          onChanged: (value) {
            model.number = value;
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
          label: 'Proveedor',
          placeholder: 'Proveedor',
          provider: DI.of(context).commonRepository.getProviders,
          initialValue: model.provider,
          itemBuilder: (item) => BasicTile(
            title: item.name,
            color: item.color,
          ),
          onChanged: (value) {
            model.provider = value;
          },
        )
      ],
    );
  }
}
