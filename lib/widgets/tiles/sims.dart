import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/sims.dart';

class SimsTile extends StatelessWidget {
  final Sims sim;

  const SimsTile({
    super.key,
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

class SimsFormTile extends StatelessWidget {
  final Sims sim;

  const SimsFormTile({
    super.key,
    required this.sim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SimsTile(sim: sim),
      ),
    );
  }
}
