import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/core/types.dart';
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
    final repo = DI.of(context).clientsRepository;
    final toast = SkToast.of(context);

    Future<void> onSave(RequestParams params) async {
      if (model.isEditing) {
        try {
          await repo.update(model.code!, params);
          toast.success(
            title: 'Exito!!',
            message: 'Editado correctamente',
          );
        } catch (e) {
          toast.error(
            title: 'Error!!',
            message: 'Error al editar',
          );
        }
      } else {
        try {
          await repo.create(params);
          toast.success(
            title: 'Exito!!',
            message: 'Creado correctamente',
          );
        } catch (e) {
          toast.error(
            title: 'Error!!',
            message: 'Error al crear',
          );
        }
      }
    }

    return SkScaffoldForm(
      model: model,
      onSend: onSave,
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
