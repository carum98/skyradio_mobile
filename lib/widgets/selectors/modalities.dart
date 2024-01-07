import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/modality.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class ModalitiesSelector extends StatelessWidget {
  final Modality? initialValue;
  final Function(Modality?) onChanged;
  final bool? showClearButton;
  final bool? isRequired;

  const ModalitiesSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.showClearButton,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect.label(
      label: 'Modalidad',
      placeholder: 'Modalidad',
      provider: DI.of(context).commonRepository.getModalities,
      showClearButton: showClearButton,
      initialValue: initialValue,
      isRequired: isRequired ?? false,
      itemBuilder: (item) => BasicTile(
        title: item.name,
        color: item.color,
      ),
      onChanged: onChanged,
    );
  }
}
