import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class RadiosActionsView extends StatelessWidget {
  final Radios radio;
  final Function onRefresh;

  const RadiosActionsView({
    super.key,
    required this.radio,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (radio.client != null)
          SkButton.block(
            text: 'Cambio',
            icon: SkIconData.arrows,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_SWAP_VIEW, arguments: radio)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        if (radio.client == null)
          SkButton.block(
            text: 'Entrega',
            icon: SkIconData.arrow_down,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              SkBottomSheet.of(context)
                  .pushNamed(CLIENT_ADD_BOTTOM_SHEET, arguments: radio)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        if (radio.client != null)
          SkButton.block(
            text: 'Devolución',
            icon: SkIconData.arrow_up,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_REMOVE_VIEW, arguments: radio)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        const Divider(),
        if (radio.sim != null)
          SkButton.block(
            text: 'Cambiar SIM',
            icon: SkIconData.arrows,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              SkBottomSheet.of(context)
                  .pushNamed(SIMS_SWAP_BOTTOM_SHEET, arguments: radio)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        if (radio.sim != null)
          SkButton.block(
            text: 'Desvicular SIM',
            icon: SkIconData.arrow_up,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              SkDialog.of(context)
                  .pushNamed(SIM_REMOVE_DIALOG, arguments: radio)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        if (radio.sim == null)
          SkButton.block(
            text: 'Relacionar SIM',
            icon: SkIconData.arrow_down,
            backgroundColor: Colors.transparent,
            textLeft: true,
            onPressed: () {
              SkBottomSheet.of(context)
                  .pushNamed(SIMS_ADD_BOTTOM_SHEET, arguments: radio)
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
                .pushNamed(RADIOS_UPDATE_VIEW, arguments: radio)
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
                .pushNamed(RADIOS_REMOVE_DIALOG, arguments: radio)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
      ],
    );
  }
}
