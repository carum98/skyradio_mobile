import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class RadiosView extends StatelessWidget {
  const RadiosView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).radiosRepository.getRadios,
      params: ApiParams(filter: RadiosFilter(), sort: ApiSortModel()),
    );

    return SkScaffold(
      title: 'Radios',
      controller: controller,
      availableEnable: const [
        SkScaffoldAction.add,
        SkScaffoldAction.filter,
        SkScaffoldAction.sort
      ],
      builder: (radio) => RadiosTile(radio: radio),
      onTap: (radio) {
        SkBottomSheet.of(context)
            .pushNamed(RADIO_BOTTOM_SHEET, arguments: radio)
            .then((value) {
          if (value == true) controller.refresh();
        });
      },
      onListActions: (action) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, RADIOS_CREATE_VIEW).then((value) {
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
            RADIOS_FILTER_BOTTOM_SHEET,
            arguments: {
              'filter': controller.params.filter,
              'onRefresh': controller.refresh,
            },
          );
        }
      },
      onItemActions: (radio) {
        SkBottomSheet.of(context).pushNamed(
          RADIOS_ACTIONS_BOTTOM_SHEET,
          arguments: {
            'radio': radio,
            'onRefresh': controller.refresh,
          },
        );
      },
    );
  }
}
