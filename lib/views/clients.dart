import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/avatar.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).clientsRepository.getClients;
    final filter = ClientsFilter();

    return SkScaffold(
      title: 'Clientes',
      provider: provider,
      builder: (client) => _Tile(client: client),
      onTap: (client) {
        Navigator.pushNamed(
          context,
          CLIENT_VIEW,
          arguments: client,
        );
      },
      onListActions: (action, callback) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, CLIENT_CREATE_VIEW);
        } else if (action == SkScaffoldAction.sort) {
          SkBottomSheet.of(context).pushNamed(
            CLIENTS_SORT_BOTTOM_SHEET,
            arguments: {
              'onSort': callback,
            },
          );
        } else if (action == SkScaffoldAction.filter) {
          SkBottomSheet.of(context).pushNamed(
            CLIENTS_FILTER_BOTTOM_SHEET,
            arguments: {
              'filter': filter,
              'onFilter': callback,
            },
          );
        }
      },
      onItemActions: (client, callback) {
        SkBottomSheet.of(context).pushNamed(
          CLIENTS_ACTIONS_BOTTOM_SHEET,
          arguments: {
            'client': client,
            'onRefresh': callback,
          },
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  final Clients client;

  const _Tile({required this.client});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SkAvatar(
        color: client.color,
        alt: client.name,
      ),
      title: Text(client.name),
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
