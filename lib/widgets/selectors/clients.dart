import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class ClientsSelector extends StatelessWidget {
  final Clients? initialValue;
  final Function(Clients?) onChanged;
  final bool? showClearButton;
  final bool? isRequired;

  const ClientsSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.showClearButton,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect.label(
      label: 'Cliente',
      placeholder: 'Cliente',
      provider: DI.of(context).clientsRepository.getClients,
      showClearButton: showClearButton,
      initialValue: initialValue,
      isRequired: isRequired ?? false,
      itemBuilder: (item) => BasicTile(
        title: item.name,
      ),
      onChanged: onChanged,
    );
  }
}
