import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/scaffold/remove_scaffold.dart';

class ClientsRemoveView extends StatelessWidget {
  final Clients client;

  const ClientsRemoveView({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return RemoveScaffold(
      instance: 'cliente',
      onRemove: () => DI.of(context).clientsRepository.delete(client.code),
    );
  }
}
