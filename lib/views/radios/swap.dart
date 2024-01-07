import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/core/toast.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';

class SwapRadiosView extends StatefulWidget {
  final Clients client;
  final Radios? radio;

  const SwapRadiosView({
    super.key,
    required this.client,
    this.radio,
  });

  @override
  State<SwapRadiosView> createState() => _SwapRadiosViewState();
}

class _SwapRadiosViewState extends State<SwapRadiosView> {
  RadiosItemForm? itemFrom;
  RadiosItemForm? itemTo;

  @override
  void initState() {
    super.initState();

    if (widget.radio != null) {
      itemFrom = RadiosItemForm(radio: widget.radio!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (itemFrom == null)
              PickerSkeleton(
                title: 'Seleccionar Radio',
                onPressed: _pickRadioFrom,
              )
            else
              RadiosFormTile(item: itemFrom!),
            const SizedBox(height: 15),
            const RotatedBox(
              quarterTurns: 1,
              child: SkIcon(SkIconData.arrows, size: 40),
            ),
            const SizedBox(height: 15),
            if (itemTo == null)
              PickerSkeleton(
                title: 'Seleccionar Radio',
                onPressed: _pickRadioTo,
              )
            else
              RadiosFormTile(item: itemTo!),
          ],
        ),
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: itemFrom != null && itemTo != null
            ? Offset.zero
            : const Offset(0, 3),
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
      final addRadios = clientsRepository.swapRadio(widget.client.code, {
        'radio_code_from': itemFrom!.code,
        'radio_code_to': itemTo!.code,
      });

      final updateRadios = [itemFrom, itemTo]
          .map((e) => radiosRepository.update(e!.code, e.getParams()))
          .toList();

      await Future.wait([addRadios, ...updateRadios]);

      toast.success(
        title: 'Exito!!',
        message: 'Cambio realizado correctamente',
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      toast.error(
        title: 'Error!!',
        message: 'Ocurrio un error al realizar el cambio',
      );
    }
  }

  void _pickRadioFrom() async {
    final radio = await Navigator.of(context).pushNamed(
      RADIOS_SELECTOR_VIEW,
      arguments: {
        'clients[code][equal]': widget.client.code,
        if (itemFrom != null) 'radios[code][not_equal]': itemFrom!.radio.code,
      },
    ) as Radios?;

    if (radio != null) {
      setState(() {
        itemFrom = RadiosItemForm(radio: radio);
      });
    }
  }

  void _pickRadioTo() async {
    final radio = await Navigator.of(context).pushNamed(
      RADIOS_SELECTOR_VIEW,
      arguments: {
        'clients[code][is_null]': '',
        if (itemTo != null) 'radios[code][not_equal]': itemTo!.radio.code,
      },
    ) as Radios?;

    if (radio != null) {
      setState(() {
        itemTo = RadiosItemForm(radio: radio);
      });
    }
  }
}
