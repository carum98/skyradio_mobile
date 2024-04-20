import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/widgets/button.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class AppsActionsView extends StatelessWidget {
  final Apps app;
  final Function onRefresh;

  const AppsActionsView({
    super.key,
    required this.app,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SkButton.block(
          text: 'Editar',
          icon: SkIconData.update,
          backgroundColor: Colors.transparent,
          textLeft: true,
          onPressed: () {
            Navigator.of(context)
                .pushNamed(APPS_UPDATE_VIEW, arguments: app)
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
                .pushNamed(APPS_REMOVE_DIALOG, arguments: app)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
      ],
    );
  }
}
