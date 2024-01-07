import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/core/types.dart';
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
    final repo = DI.of(context).simsRepository;
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
          label: 'Numero',
          placeholder: 'Numero de sim',
          initialValue: model.number,
          autofocus: true,
          isRequired: true,
          minLength: 3,
          maxLength: 12,
          onChanged: (value) {
            model.number = value;
          },
        ),
        SkInput.label(
          label: 'Serial',
          placeholder: 'Serial',
          initialValue: model.serial,
          minLength: 3,
          maxLength: 15,
          onChanged: (value) {
            model.serial = value;
          },
        ),
        SkLabel(
          label: 'Proveedor',
          child: ProvidersSelector(
            initialValue: model.provider,
            isRequired: true,
            onChanged: (value) {
              model.provider = value;
            },
          ),
        ),
      ],
    );
  }
}
