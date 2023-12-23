import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';
import 'package:skyradio_mobile/widgets/tiles/sims.dart';

class SimsView extends StatelessWidget {
  const SimsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).simsRepository.getSims,
      params: ApiParams(filter: SimsFilter(), sort: ApiSortModel()),
    );

    return SkScaffold(
      title: 'Sims',
      controller: controller,
      builder: (sim) => SimsTile(sim: sim),
      onTap: (sim) => SkBottomSheet.of(context).pushNamed(
        SIM_BOTTOM_SHEET,
        arguments: sim,
      ),
      onListActions: (action) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, SIMS_CREATE_VIEW).then((value) {
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
            SIMS_FILTER_BOTTOM_SHEET,
            arguments: {
              'filter': controller.params.filter,
              'onRefresh': controller.refresh,
            },
          );
        }
      },
      onItemActions: (sim, callback) {
        SkBottomSheet.of(context).pushNamed(
          SIMS_ACTIONS_BOTTOM_SHEET,
          arguments: {
            'sim': sim,
            'onRefresh': callback,
          },
        );
      },
    );
  }
}
