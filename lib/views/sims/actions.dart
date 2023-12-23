import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class SimsActionsView extends StatelessWidget {
  final Sims sim;
  final Function onRefresh;

  const SimsActionsView({
    super.key,
    required this.sim,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkButton.block(
          text: 'Relacionar Radio',
          icon: SkIconData.arrow_up,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        SkButton.block(
          text: 'Cambiar SIM',
          icon: SkIconData.arrows,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {},
        ),
        SkButton.block(
          text: 'Desvincular SIM',
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
                .pushNamed(SIMS_UPDATE_VIEW, arguments: sim)
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
                .pushNamed(SIMS_REMOVE_DIALOG, arguments: sim)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
      ],
    );
  }
}
