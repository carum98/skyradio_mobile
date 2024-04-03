import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';
import 'package:skyradio_mobile/widgets/tiles/apps.dart';

class AppsView extends StatelessWidget {
  const AppsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).appsRepository.getApps,
    );

    return SkScaffold(
      title: 'Apps',
      controller: controller,
      availableEnable: const [
        SkScaffoldAction.add,
      ],
      builder: (app) => AppsTile(app: app),
      onTap: (app) {
        SkBottomSheet.of(context)
            .pushNamed(APP_BOTTOM_SHEET, arguments: app)
            .then((value) {
          if (value == true) controller.refresh();
        });
      },
      onListActions: (action) {
        if (action == SkScaffoldAction.add) {
          Navigator.pushNamed(context, APPS_CREATE_VIEW).then((value) {
            if (value == true) controller.refresh();
          });
        }
      },
      onItemActions: (app) {
        SkBottomSheet.of(context).pushNamed(
          APP_ACTIONS_BOTTOM_SHEET,
          arguments: {
            'app': app,
            'onRefresh': controller.refresh,
          },
        );
      },
    );
  }
}
