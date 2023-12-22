import 'package:flutter/material.dart';
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
      children: [
        SkButton.block(
          text: 'Cambio',
          icon: SkIconData.arrows,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        SkButton.block(
          text: 'Entrega',
          icon: SkIconData.arrow_down,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        SkButton.block(
          text: 'Devolución',
          icon: SkIconData.arrow_up,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        const Divider(),
        SkButton.block(
          text: 'Cambiar SIM',
          icon: SkIconData.arrows,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        SkButton.block(
          text: 'Devolución SIM',
          icon: SkIconData.arrow_up,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        const Divider(),
        SkButton.block(
          text: 'Actualizar',
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
          onPressed: () {},
        ),
      ],
    );
  }
}
