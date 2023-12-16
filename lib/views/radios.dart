import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/radios_tile.dart';
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
    );
  }
}
