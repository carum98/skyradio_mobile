import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/color_picker.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';
import 'package:skyradio_mobile/widgets/selectors/modalities.dart';
import 'package:skyradio_mobile/widgets/selectors/sellers.dart';

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
      onSend: (params) async {
        if (model.isEditing) {
          await DI.of(context).clientsRepository.update(model.code!, params);
        } else {
          await DI.of(context).clientsRepository.create(params);
        }
      },
      builder: (model) => [
        SkInput.label(
          label: 'Nombre',
          placeholder: 'Nombre del cliente',
          initialValue: model.name,
          autofocus: true,
          onChanged: (value) {
            model.name = value;
          },
        ),
        ModalitiesSelector(
          initialValue: model.modality,
          onChanged: (value) {
            model.modality = value;
          },
        ),
        SellersSelector(
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
