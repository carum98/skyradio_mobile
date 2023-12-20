import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/modality.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class ModalitiesSelector extends StatelessWidget {
  final Modality? initialValue;
  final Function(Modality) onChanged;

  const ModalitiesSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect.label(
      label: 'Modalidad',
      placeholder: 'Modalidad',
      provider: DI.of(context).commonRepository.getModalities,
      initialValue: initialValue,
      itemBuilder: (item) => BasicTile(
        title: item.name,
        color: item.color,
      ),
      onChanged: onChanged,
    );
  }
}
