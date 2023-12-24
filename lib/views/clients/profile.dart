import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/utils/rebuild.dart';
import 'package:skyradio_mobile/widgets/avatar.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/chart.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';
import 'package:skyradio_mobile/widgets/search_input.dart';
import 'package:skyradio_mobile/widgets/tabs.dart';

class ClientView extends StatelessWidget {
  final Clients client;

  const ClientView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final listController = SkListViewPaginationController(
      provider: (params) =>
          DI.of(context).clientsRepository.getRadios(client.code, params),
      params: ApiParams(),
    );

    final rebuildController = RebuildController();

    void onRefresh() {
      listController.refresh();
      rebuildController.rebuild();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _SliverAppBar(client: client),
          _SliverHeader(client: client),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          RebuildWrapper(
            controller: rebuildController,
            child: _SliverChart(client: client),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
          _SliverRadios(controller: listController),
        ],
      ),
      floatingActionButton: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        children: [
          _ActionsButtons(
            color: const Color.fromRGBO(7, 80, 188, 1),
            icon: SkIconData.arrows,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_SWAP_VIEW, arguments: client)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
          _ActionsButtons(
            color: const Color.fromRGBO(191, 42, 42, 1),
            icon: SkIconData.arrow_up,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_REMOVE_VIEW, arguments: client)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
          _ActionsButtons(
            color: const Color.fromRGBO(58, 160, 58, 1),
            icon: SkIconData.arrow_down,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RADIOS_ADD_VIEW, arguments: client)
                  .then((value) => {if (value == true) onRefresh()});
            },
          ),
        ],
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  final Clients client;

  const _SliverAppBar({required this.client});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      pinned: true,
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
          onPressed: () {
            SkBottomSheet.of(context).pushNamed(
              CLIENTS_ACTIONS_BOTTOM_SHEET,
              arguments: {'client': client, 'onRefresh': () {}},
            );
          },
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}

class _SliverHeader extends StatelessWidget {
  final Clients client;

  const _SliverHeader({required this.client});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Container(
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
        ),
      ),
    );
  }
}

class _SliverChart extends StatelessWidget {
  final Clients client;

  const _SliverChart({required this.client});

  @override
  Widget build(BuildContext context) {
    final provider = DI.of(context).clientsRepository.getStats;

    return FutureBuilder<ClientsStats>(
      future: provider(client.code),
      builder: (_, snapshot) {
        final models = snapshot.data?.models
            .map((e) => SkChartData(e.name, e.color, e.count, e.percent))
            .toList();

        final providers = snapshot.data?.providers
            .map((e) => SkChartData(e.name, e.color, e.count, e.percent))
            .toList();

        return SliverToBoxAdapter(
          child: SkTabs(
            tabs: [
              SkTab(
                label: 'Modelos',
                child: SkChart(
                  size: 100,
                  data: models ?? [],
                ),
              ),
              SkTab(
                label: 'Proveedores',
                child: SkChart(
                  size: 100,
                  data: providers ?? [],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliverRadios extends StatelessWidget {
  final SkListViewPaginationController<Radios> controller;

  const _SliverRadios({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 140,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.only(left: 10),
                  child: SkSearchInput(onChanged: controller.search),
                ),
              ],
            ),
            Expanded(
              child: SkListViewPagination(
                controller: controller,
                builder: (radio) => RadiosTile(radio: radio),
                onTap: (radio) => SkBottomSheet.of(context).pushNamed(
                  RADIO_BOTTOM_SHEET,
                  arguments: radio,
                ),
              ),
            ),
          ],
        ),
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
