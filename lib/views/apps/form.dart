import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';
import 'package:skyradio_mobile/widgets/selectors/clients.dart';
import 'package:skyradio_mobile/widgets/selectors/licenses.dart';

class AppsFormView extends StatelessWidget {
  final AppsForm model;

  const AppsFormView({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final repo = DI.of(context).appsRepository;
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
        ClientsSelector(
          initialValue: model.client,
          isRequired: true,
          onChanged: (value) {
            model.client = value;
          },
        ),
        SkInput.label(
          label: 'Nombre',
          placeholder: 'Nombre',
          initialValue: model.name,
          autofocus: true,
          isRequired: true,
          minLength: 3,
          maxLength: 12,
          onChanged: (value) {
            model.name = value;
          },
        ),
        LicenseSelector(
          initialValue: model.license,
          onChanged: (value) {
            model.license = value;
          },
        )
      ],
    );
  }
}
