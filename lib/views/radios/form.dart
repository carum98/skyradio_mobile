import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/core/types.dart';
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
    final repo = DI.of(context).radiosRepository;
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
      builder: (value) => [
        SkInput.label(
          label: 'Nombre',
          placeholder: 'Nombre del radio',
          initialValue: model.name,
          autofocus: true,
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
