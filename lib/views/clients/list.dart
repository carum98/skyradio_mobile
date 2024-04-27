import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';
import 'package:skyradio_mobile/widgets/tiles/clients.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = DI.of(context).state.user;

    final controller = SkListViewPaginationController(
      provider: DI.of(context).clientsRepository.getClients,
      params: ApiParams(filter: ClientsFilter(), sort: ApiSortModel()),
    );

    return SkScaffold(
      title: 'Clientes',
      controller: controller,
      availableEnable: [
        if (user.isAdmin || user.isUser) SkScaffoldAction.add,
        if (user.isAdmin || user.isUser) SkScaffoldAction.actions,
        SkScaffoldAction.filter,
        SkScaffoldAction.sort
      ],
      builder: (client) => ClientsTile(client: client),
      onTap: (client) {
        Navigator.of(context)
            .pushNamed(CLIENT_VIEW, arguments: client)
            .then((value) {
          if (value == true) controller.refresh();
        });
      },
      onListActions: (action) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, CLIENT_CREATE_VIEW).then((value) {
            if (value == true) controller.refresh();
          });
        } else if (action == SkScaffoldAction.sort) {
          SkBottomSheet.of(context).pushNamed(
            SORT_LIST_BOTTOM_SHEET,
            arguments: {
              'sort': controller.params.sort,
              'onRefresh': controller.refresh,
            },
          );
        } else if (action == SkScaffoldAction.filter) {
          SkBottomSheet.of(context).pushNamed(
            CLIENTS_FILTER_BOTTOM_SHEET,
            arguments: {
              'filter': controller.params.filter,
              'onRefresh': controller.refresh,
            },
          );
        }
      },
      onItemActions: (client) {
        SkBottomSheet.of(context).pushNamed(
          CLIENTS_ACTIONS_BOTTOM_SHEET,
          arguments: {
            'client': client,
            'onRefresh': controller.refresh,
          },
        );
      },
    );
  }
}
