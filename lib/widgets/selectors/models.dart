import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/models.dart';
import 'package:skyradio_mobile/widgets/select.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';

class ModelsSelectors extends StatelessWidget {
  final Models? initialValue;
  final ValueChanged<Models?> onChanged;
  final bool? showClearButton;

  const ModelsSelectors({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.showClearButton,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect(
      placeholder: 'Modelo',
      provider: DI.of(context).commonRepository.getModels,
      showClearButton: showClearButton,
      initialValue: initialValue,
      itemBuilder: (item) => BasicTile(
        title: item.name,
        color: item.color,
      ),
      onChanged: onChanged,
    );
  }
}
