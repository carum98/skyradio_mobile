import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/dialog.dart';
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
  final ValueNotifier<Clients> client;

  ClientView({super.key, required Clients client})
      : client = ValueNotifier(client);

  @override
  Widget build(BuildContext context) {
    bool wasEdited = false;
    final repository = DI.of(context).clientsRepository;

    final listController = SkListViewPaginationController(
      provider: (params) => repository.getRadios(client.value.code, params),
      params: ApiParams(filter: RadiosFilter(), sort: ApiSortModel()),
    );

    final rebuildController = RebuildController();

    void onRefreshList() {
      listController.refresh();
      rebuildController.rebuild();
    }

    void onRefreshClient() {
      repository.get(client.value.code).then((value) => {
            wasEdited = true,
            client.value = value,
          });
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop(wasEdited);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ListenableBuilder(
              listenable: client,
              builder: (_, __) => _SliverAppBar(
                client: client.value,
                onRefresh: onRefreshClient,
              ),
            ),
            ListenableBuilder(
              listenable: client,
              builder: (_, __) => _SliverHeader(client: client.value),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            RebuildWrapper(
              controller: rebuildController,
              child: _SliverChart(client: client.value),
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
                    .then((value) => {if (value == true) onRefreshList()});
              },
            ),
            _ActionsButtons(
              color: const Color.fromRGBO(191, 42, 42, 1),
              icon: SkIconData.arrow_up,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RADIOS_REMOVE_VIEW, arguments: client)
                    .then((value) => {if (value == true) onRefreshList()});
              },
            ),
            _ActionsButtons(
              color: const Color.fromRGBO(58, 160, 58, 1),
              icon: SkIconData.arrow_down,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RADIOS_ADD_VIEW, arguments: client)
                    .then((value) => {if (value == true) onRefreshList()});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  final Clients client;
  final VoidCallback onRefresh;

  const _SliverAppBar({
    required this.client,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(color: Colors.transparent),
        ),
      ),
      pinned: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SkAvatar(
            code: client.code,
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
        _ClientActions(
          client: client,
          onRefresh: onRefresh,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SkSearchInput(onChanged: controller.search),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(45, 45),
                    ),
                    child: const SkIcon(SkIconData.filter, size: 20),
                    onPressed: () {
                      SkBottomSheet.of(context).pushNamed(
                        RADIOS_FILTER_BOTTOM_SHEET,
                        arguments: {
                          'filter': controller.params.filter,
                          'onRefresh': controller.refresh,
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(45, 45),
                    ),
                    child: const SkIcon(SkIconData.sort, size: 20),
                    onPressed: () {
                      SkBottomSheet.of(context).pushNamed(
                        SORT_LIST_BOTTOM_SHEET,
                        arguments: {
                          'sort': controller.params.sort,
                          'onRefresh': controller.refresh,
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: SkListViewPagination(
                controller: controller,
                builder: (radio) => RadiosTile(radio: radio),
                onTap: (radio) => SkBottomSheet.of(context).pushNamed(
                  RADIO_BOTTOM_SHEET,
                  arguments: radio,
                ),
                onLongPress: (radio) => SkBottomSheet.of(context).pushNamed(
                  RADIOS_ACTIONS_BOTTOM_SHEET,
                  arguments: {
                    'radio': radio,
                    'onRefresh': controller.refresh,
                  },
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

class _ClientActions extends StatelessWidget {
  final Clients client;
  final VoidCallback onRefresh;

  const _ClientActions({
    required this.client,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      offset: const Offset(0, 40),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            Navigator.of(context)
                .pushNamed(CLIENT_UPDATE_VIEW, arguments: client)
                .then((value) => {if (value == true) onRefresh()});
            break;
          case 'delete':
            SkDialog.of(context)
                .pushNamed(CLIENTS_REMOVE_DIALOG, arguments: client)
                .then((value) =>
                    {if (value == true) Navigator.of(context).pop()});
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'edit',
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SkIcon(SkIconData.update, size: 20),
              SizedBox(width: 10),
              Text('Actualizar', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SkIcon(SkIconData.trash, size: 20),
              SizedBox(width: 10),
              Text('Eliminar', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
