import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class SimsView extends StatelessWidget {
  const SimsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).simsRepository.getSims;

    return SkScaffold(
      title: 'Sims',
      provider: provider,
      builder: (sim) => _Tile(sim: sim),
      onTap: (sim) => SkBottomSheet.of(context).pushNamed(
        SIM_BOTTOM_SHEET,
        arguments: sim,
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final Sims sim;

  const _Tile({
    required this.sim,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sim.number),
      trailing: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              size: 14,
              color: sim.provider.color,
            ),
            const SizedBox(width: 5),
            Text(
              sim.provider.name,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
