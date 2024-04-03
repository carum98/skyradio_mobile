import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/selectors/licenses.dart';

class AppsTile extends StatelessWidget {
  final Apps app;

  const AppsTile({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.name),
      trailing: app.license != null
          ? Text(
              app.license!.key,
              style: const TextStyle(fontSize: 14),
            )
          : null,
    );
  }
}

class AppsFormTile extends StatelessWidget {
  final AppsItemForm item;

  const AppsFormTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SkInput(
            placeholder: 'Nombre',
            initialValue: item.name,
            autofocus: true,
            onChanged: (value) {
              item.name = value;
            },
          ),
          const SizedBox(height: 15),
          LicenseSelector(
            initialValue: item.license,
            onChanged: (value) {
              item.license = value;
            },
          ),
        ],
      ),
    );
  }
}
