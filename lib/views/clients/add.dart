import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/picker_skeleton.dart';
import 'package:skyradio_mobile/widgets/tiles/clients.dart';

class AddClientView extends StatefulWidget {
  final Radios radio;

  const AddClientView({
    super.key,
    required this.radio,
  });

  @override
  State<AddClientView> createState() => _AddClientViewState();
}

class _AddClientViewState extends State<AddClientView> {
  Clients? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          if (item != null)
            ClientFormTile(client: item!)
          else
            PickerSkeleton(
              title: 'Seleccionar Cliente',
              onPressed: _pickClient,
            ),
        ],
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: item != null ? Offset.zero : const Offset(0, 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SkButton(
              onPressed: _onSend,
              text: 'Guardar',
            ),
          ],
        ),
      ),
    );
  }

  void _onSend() {
    final radiosRepository = DI.of(context).radiosRepository;

    radiosRepository.addClient(widget.radio.code, {
      'client_code': item!.code,
    }).then((_) {
      Navigator.pop(context, true);
    });
  }

  void _pickClient() async {
    final sim = await Navigator.of(context).pushNamed(
      CLIENT_SELECTOR_VIEW,
      arguments: {
        if (item != null) 'clients[code][not_equal]': item!.code,
      },
    ) as Clients?;

    if (sim != null) {
      setState(() {
        item = sim;
      });
    }
  }
}
