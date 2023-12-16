import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/radios.dart';

class RadiosTile extends StatelessWidget {
  final Radios radio;

  const RadiosTile({
    super.key,
    required this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(radio.imei),
      trailing: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              size: 14,
              color: radio.model.color,
            ),
            const SizedBox(width: 5),
            Text(
              radio.model.name,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
