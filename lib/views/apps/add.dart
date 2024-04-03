import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/apps.dart';

class AddAppsView extends StatefulWidget {
  final Clients client;

  const AddAppsView({
    super.key,
    required this.client,
  });

  @override
  State<AddAppsView> createState() => _AddAppsViewState();
}

class _AddAppsViewState extends State<AddAppsView> {
  final List<AppsItemForm> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Apps'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (_, index) => AppsFormTile(item: items[index]),
            ),
            const SizedBox(height: 20),
            PickerSkeleton(
              title: 'Nueva App',
              onPressed: () {
                setState(() {
                  items.add(AppsItemForm());
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: items.isNotEmpty ? Offset.zero : const Offset(0, 3),
        child: SkButton(
          onPressed: _onSend,
          text: 'Guardar',
        ),
      ),
    );
  }

  void _onSend() async {
    final clientsRepository = DI.of(context).clientsRepository;
    final toast = SkToast.of(context);

    try {
      await Future.wait(items
          .map((e) => clientsRepository.addApp(
                widget.client.code,
                e.getParams(),
              ))
          .toList());

      toast.success(
        title: 'Exito!!',
        message: 'Entrega realizada correctamente',
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      toast.error(
        title: 'Error!!',
        message: 'Ocurrio un error al realizar la entrega',
      );
    }
  }
}
