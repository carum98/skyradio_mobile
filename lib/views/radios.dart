import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/widgets/bottom_sheet.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class RadiosView extends StatelessWidget {
  const RadiosView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).radiosRepository.getRadios;

    return SkScaffold(
      title: 'Radios',
      provider: provider,
      builder: (radio) => RadiosTile(radio: radio),
      onTap: (radio) => SkBottomSheet.of(context).pushNamed(
        RADIO_BOTTOM_SHEET,
        arguments: radio,
      ),
      onListActions: (action) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, RADIOS_CREATE_VIEW);
        } else if (action == SkScaffoldAction.sort) {
          skBottomSheet(context, Container());
        } else if (action == SkScaffoldAction.filter) {
          skBottomSheet(context, Container());
        }
      },
      onItemActions: (client, callback) {
        skBottomSheet(context, Container());
      },
    );
  }
}
