import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/label.dart';
import 'package:skyradio_mobile/widgets/selectors/providers.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';

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
      onSend: (params) async {
        if (model.isEditing) {
          await DI.of(context).simsRepository.update(model.code!, params);
        } else {
          await DI.of(context).simsRepository.create(params);
        }
      },
      builder: (value) => [
        SkInput.label(
          label: 'Numero',
          placeholder: 'Numero de sim',
          initialValue: model.number,
          autofocus: true,
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
        SkLabel(
          label: 'Proveedor',
          child: ProvidersSelector(
            initialValue: model.provider,
            onChanged: (value) {
              model.provider = value;
            },
          ),
        ),
      ],
    );
  }
}
