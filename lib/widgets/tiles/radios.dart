import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/input.dart';
import 'package:skyradio_mobile/widgets/selectors/sims.dart';

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

class RadiosFormTile extends StatelessWidget {
  final RadiosItemForm item;

  const RadiosFormTile({
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 15,
              right: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SkInput(
                    placeholder: 'Nombre',
                    initialValue: item.name,
                    onChanged: (value) {
                      item.name = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 130,
                  child: SimsSelector(
                    initialValue: item.sim,
                    onChanged: (value) {
                      item.sim = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          RadiosTile(radio: item.radio),
        ],
      ),
    );
  }
}
