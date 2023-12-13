import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class SimsView extends StatelessWidget {
  const SimsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).simsRepository.getSims;

    return SkScaffold(
      title: 'Sims',
      provider: provider,
      builder: (radio) => ListTile(
        title: Text(radio.code),
        subtitle: Text(radio.number),
      ),
    );
  }
}
