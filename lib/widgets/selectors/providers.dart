import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/providers.dart';
import 'package:skyradio_mobile/widgets/select.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';

class ProvidersSelector extends StatelessWidget {
  final Providers? initialValue;
  final ValueChanged<Providers> onChanged;

  const ProvidersSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect(
      placeholder: 'Proveedor',
      provider: DI.of(context).commonRepository.getProviders,
      initialValue: initialValue,
      itemBuilder: (item) => BasicTile(
        title: item.name,
        color: item.color,
      ),
      onChanged: onChanged,
    );
  }
}
