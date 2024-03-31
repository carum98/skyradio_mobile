import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/console.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';
import 'package:skyradio_mobile/widgets/selectors/licenses.dart';

class ConsoleFormView extends StatelessWidget {
  final Clients? client;
  final ConsoleForm model;

  const ConsoleFormView({
    super.key,
    this.client,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final repo = DI.of(context).consolesRepository;
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
          await repo.create(client!.code, params);
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
