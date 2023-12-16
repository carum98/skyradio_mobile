import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/avatar.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/radios_tile.dart';
import 'package:skyradio_mobile/widgets/search_input.dart';

class ClientView extends StatelessWidget {
  final Clients client;

  const ClientView({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: _Header(client: client),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.only(left: 10),
            child: SkSearchInput(onChanged: (v) {}),
          ),
          Expanded(
            child: _Radios(client: client),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Clients client;

  const _Header({required this.client});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Wrap(
        runSpacing: 15,
        children: [
          Row(
            children: [
              SkAvatar(
                color: client.color,
                alt: client.name,
              ),
              const SizedBox(width: 10),
              Text(
                client.name,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Vendedor: ',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: client.seller?.name ?? 'Sin vendedor',
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Modalidad: ',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: client.modality.name,
                color: client.modality.color,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Radios extends StatelessWidget {
  final Clients client;
  const _Radios({required this.client});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).clientsRepository.getRadios;

    return SkListViewPagination(
      provider: (params) => provider(client.code, params),
      builder: (radio) => RadiosTile(radio: radio),
    );
  }
}
