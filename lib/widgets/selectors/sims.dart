import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/select.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';

class SimsSelector extends StatelessWidget {
  final Sims? initialValue;
  final ValueChanged<Sims> onChanged;

  const SimsSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect(
      placeholder: 'SIM',
      provider: DI.of(context).simsRepository.getSims,
      initialValue: initialValue,
      itemBuilder: (item) => BasicTile(title: item.number),
      onChanged: onChanged,
    );
  }
}
