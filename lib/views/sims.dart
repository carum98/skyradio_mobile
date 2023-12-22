import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/bottom_sheet.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

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
      builder: (sim) => _Tile(sim: sim),
      onTap: (sim) => SkBottomSheet.of(context).pushNamed(
        SIM_BOTTOM_SHEET,
        arguments: sim,
      ),
      onListActions: (action) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, RADIOS_CREATE_VIEW);
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
      onItemActions: (client, callback) {
        skBottomSheet(context, Container());
      },
    );
  }
}

class _Tile extends StatelessWidget {
  final Sims sim;

  const _Tile({
    required this.sim,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sim.number),
      trailing: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              size: 14,
              color: sim.provider.color,
            ),
            const SizedBox(width: 5),
            Text(
              sim.provider.name,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
