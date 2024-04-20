import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class ClientsActionsView extends StatelessWidget {
  final Clients client;
  final Function onRefresh;

  const ClientsActionsView({
    super.key,
    required this.client,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (client.radiosCount > 0)
          SkButton.block(
            text: 'Cambio',
            icon: SkIconData.arrows,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_SWAP_VIEW, arguments: client)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        SkButton.block(
          text: 'Entrega',
          icon: SkIconData.arrow_down,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {
            Navigator.of(context)
                .pushNamed(RADIOS_ADD_VIEW, arguments: client)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
        if (client.radiosCount > 0)
          SkButton.block(
            text: 'Devolución',
            icon: SkIconData.arrow_up,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_REMOVE_VIEW, arguments: client)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        const Divider(),
        (client.consoleEnable)
            ? SkButton.block(
                text: 'Deshabilitar consola',
                icon: SkIconData.console_disable,
                backgroundColor: Colors.transparent,
                textLeft: true,
                onPressed: () {
                  SkDialog.of(context)
                      .pushNamed(CONSOLE_REMOVE_DIALOG,
                          arguments: client.console)
                      .then((value) => {if (value == true) onRefresh()});
                },
              )
            : SkButton.block(
                text: 'Habilitar consola',
                icon: SkIconData.console_enable,
                backgroundColor: Colors.transparent,
                textLeft: true,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CONSOLE_CREATE_VIEW, arguments: client)
                      .then((value) => {if (value == true) onRefresh()});
                },
              ),
        const Divider(),
        SkButton.block(
          text: 'Editar',
          icon: SkIconData.update,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {
            Navigator.of(context)
                .pushNamed(CLIENT_UPDATE_VIEW, arguments: client)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
        SkButton.block(
          text: 'Eliminar',
          icon: SkIconData.trash,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {
            SkDialog.of(context)
                .pushNamed(CLIENTS_REMOVE_DIALOG, arguments: client)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
      ],
    );
  }
}
