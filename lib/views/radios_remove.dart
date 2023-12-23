import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/scaffold/remove_scaffold.dart';

class RadiosRemoveView extends StatelessWidget {
  final Radios radio;

  const RadiosRemoveView({
    super.key,
    required this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return RemoveScaffold(
      instance: 'radios',
      onRemove: () => DI.of(context).radiosRepository.delete(radio.code),
    );
  }
}
