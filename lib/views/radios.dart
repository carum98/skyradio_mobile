import 'package:flutter/material.dart';
import 'package:skyradio_mobile/bloc/radios/radios_bloc.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold.dart';

class RadiosView extends StatelessWidget {
  const RadiosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkScaffold(
      title: 'Radios',
      bloc: RadiosBloc(
        repository: DI.of(context).radiosRepository,
      ),
    );
  }
}
