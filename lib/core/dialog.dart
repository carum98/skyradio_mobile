// ignore_for_file: constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/views/sims/remove.dart';
import 'package:skyradio_mobile/widgets/dialog.dart';
import 'package:skyradio_mobile/widgets/scaffold/remove_scaffold.dart';

import 'dependency_inyection.dart';

class SkDialog extends InheritedWidget {
  late BuildContext _context;

  SkDialog({
    super.key,
    required super.child,
  });

  Future<T?> pushNamed<T>(String name, {Object? arguments}) async {
    final settings = RouteSettings(
      name: name,
      arguments: arguments,
    );

    return skDialog<T>(
      _context,
      DialogGenerator.generate(settings, _context),
    );
  }

  static SkDialog of(BuildContext context) {
    final instance = context.dependOnInheritedWidgetOfExactType<SkDialog>()!;

    instance._context = context;

    return instance;
  }

  @override
  bool updateShouldNotify(SkDialog oldWidget) => false;
}

const RADIOS_REMOVE_DIALOG = '/radio_remove_dialog';
const CLIENTS_REMOVE_DIALOG = '/client_remove_dialog';
const SIMS_REMOVE_DIALOG = '/sims_remove_dialog';
const SIM_REMOVE_DIALOG = '/sim_remove_dialog';

class DialogGenerator {
  static Widget generate(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case RADIOS_REMOVE_DIALOG:
        final radio = settings.arguments as Radios;

        return RemoveScaffold(
          instance: 'radio',
          onRemove: () => DI.of(context).radiosRepository.delete(radio.code),
        );

      case CLIENTS_REMOVE_DIALOG:
        final client = settings.arguments as Clients;

        return RemoveScaffold(
          instance: 'cliente',
          onRemove: () => DI.of(context).clientsRepository.delete(client.code),
        );

      case SIMS_REMOVE_DIALOG:
        final sim = settings.arguments as Sims;

        return RemoveScaffold(
          instance: 'SIM',
          onRemove: () => DI.of(context).simsRepository.delete(sim.code),
        );

      case SIM_REMOVE_DIALOG:
        final args = settings.arguments;

        final radio = args is Radios ? args : null;
        final sim = args is Sims ? args : null;

        return RemoveSimsView(
          radio: radio ?? sim!.radio!,
          sim: sim ?? radio!.sim!,
        );
      default:
        return Container();
    }
  }
}
