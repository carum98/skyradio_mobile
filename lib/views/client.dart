import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/avatar.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SkAvatar(
              color: client.color,
              alt: client.name,
            ),
            const SizedBox(width: 10),
            Text(
              client.name,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
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
      floatingActionButton: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        children: [
          _ActionsButtons(
            onPressed: () {},
            color: const Color.fromRGBO(7, 80, 188, 1),
            icon: SkIconData.arrows,
          ),
          _ActionsButtons(
            onPressed: () {},
            color: const Color.fromRGBO(191, 42, 42, 1),
            icon: SkIconData.arrow_up,
          ),
          _ActionsButtons(
            onPressed: () {},
            color: const Color.fromRGBO(58, 160, 58, 1),
            icon: SkIconData.arrow_down,
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
      onTap: (radio) => SkBottomSheet.of(context).pushNamed(
        RADIO_BOTTOM_SHEET,
        arguments: radio,
      ),
    );
  }
}

class _ActionsButtons extends StatelessWidget {
  final SkIconData icon;
  final Color color;
  final void Function() onPressed;

  const _ActionsButtons({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        backgroundColor: color,
        minimumSize: const Size(50, 50),
      ),
      child: SkIcon(
        icon,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
