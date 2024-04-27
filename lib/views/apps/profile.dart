import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/widgets/badget.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_profile.dart';

class AppView extends StatelessWidget {
  final Apps app;

  const AppView({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    final user = DI.of(context).state.user;

    return SkScaffoldProfile(
      item: app,
      title: app.name,
      onActions: (value, callback) {
        if (user.isAdmin || user.isUser) {
          SkBottomSheet.of(context).pushNamed(
            APP_ACTIONS_BOTTOM_SHEET,
            arguments: {
              'app': value,
              'onRefresh': () async {
                final app =
                    await DI.of(context).appsRepository.getApp(value.code);
                callback(app);
              },
            },
          );
        }
      },
      builder: (value) => [
        if (value.license != null)
          Row(
            children: [
              const Text(
                'Licencia:',
                style: TextStyle(fontSize: 16),
              ),
              SkBadge(
                label: value.license!.key,
              ),
            ],
          ),
        Row(
          children: [
            const Text(
              'Cliente:',
              style: TextStyle(fontSize: 16),
            ),
            SkBadge(
              label: value.client.name,
              color: value.client.color,
            ),
          ],
        ),
      ],
    );
  }
}
