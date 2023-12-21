import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/label.dart';
import 'package:skyradio_mobile/widgets/selectors/models.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';

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
        SkLabel(
          label: 'Modelo',
          child: ModelsSelectors(
            initialValue: model.model,
            onChanged: (value) {
              model.model = value;
            },
          ),
        ),
      ],
    );
  }
}
