import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/avatar.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).clientsRepository.getClients;

    return SkScaffold(
      title: 'Clients',
      provider: provider,
      builder: (client) => ListTile(
        leading: SkAvatar(
          color: client.color,
          alt: client.name,
        ),
        title: Text(client.name),
      ),
    );
  }
}
