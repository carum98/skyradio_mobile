import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';

class RemoveRadiosView extends StatefulWidget {
  final Clients client;
  final Radios? radio;

  const RemoveRadiosView({
    super.key,
    required this.client,
    this.radio,
  });

  @override
  State<RemoveRadiosView> createState() => _AddRadiosViewState();
}

class _AddRadiosViewState extends State<RemoveRadiosView> {
  final List<RadiosItemForm> items = [];

  @override
  void initState() {
    super.initState();

    if (widget.radio != null) {
      items.add(RadiosItemForm(radio: widget.radio!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devolución'),
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
              itemBuilder: (_, index) => RadiosFormTile(item: items[index]),
            ),
            const SizedBox(height: 20),
            PickerSkeleton(
              title: 'Seleccionar Radio',
              onPressed: _pickRadio,
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
    final radiosRepository = DI.of(context).radiosRepository;
    final toast = SkToast.of(context);

    try {
      final addRadios = clientsRepository.removeRadio(widget.client.code, {
        'radios_codes': items.map((e) => e.radio.code).toList(),
      });

      final updateRadios = items
          .map((e) => radiosRepository.update(e.radio.code, e.getParams()))
          .toList();

      await Future.wait([addRadios, ...updateRadios]);

      toast.success(
        title: 'Exito!!',
        message: 'Devolucion realizada correctamente',
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      toast.error(
        title: 'Error!!',
        message: 'Ocurrio un error al realizar la devolucion',
      );
    }
  }

  void _pickRadio() async {
    final radio = await Navigator.of(context).pushNamed(
      RADIOS_SELECTOR_VIEW,
      arguments: {
        'clients[code][equal]': widget.client.code,
        if (items.isNotEmpty)
          'radios[code][not_in]': items.map((e) => e.radio.code).join(','),
      },
    ) as Radios?;

    if (radio != null) {
      setState(() {
        items.add(RadiosItemForm(radio: radio));
      });
    }
  }
}
