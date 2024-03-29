import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/avatar.dart';

class ClientsTile extends StatelessWidget {
  final Clients client;

  const ClientsTile({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SkAvatar(
        code: client.code,
        color: client.color,
        alt: client.name,
      ),
      title: Text(
        client.name,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Opacity(
        opacity: client.radiosCount > 0 ? 1 : 0.5,
        child: Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              client.radiosCount.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class ClientFormTile extends StatelessWidget {
  final Clients client;

  const ClientFormTile({
    super.key,
    required this.client,
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
        child: ClientsTile(client: client),
      ),
    );
  }
}
