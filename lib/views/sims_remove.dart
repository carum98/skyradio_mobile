import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/scaffold/remove_scaffold.dart';

class SimsRemoveView extends StatelessWidget {
  final Sims sim;

  const SimsRemoveView({
    super.key,
    required this.sim,
  });

  @override
  Widget build(BuildContext context) {
    return RemoveScaffold(
      instance: 'SIM',
      onRemove: () => DI.of(context).simsRepository.delete(sim.code),
    );
  }
}
