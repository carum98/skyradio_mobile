// ignore_for_file: constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/views/clients/remove.dart';
import 'package:skyradio_mobile/views/radios/remove.dart';
import 'package:skyradio_mobile/views/sims/remove.dart';
import 'package:skyradio_mobile/widgets/dialog.dart';

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
      DialogGenerator.generate(settings),
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
const SIMS_REMOVE_DIALOG = '/sim_remove_dialog';

class DialogGenerator {
  static Widget generate(RouteSettings settings) {
    switch (settings.name) {
      case RADIOS_REMOVE_DIALOG:
        return RadiosRemoveView(
          radio: settings.arguments as Radios,
        );
      case CLIENTS_REMOVE_DIALOG:
        return ClientsRemoveView(
          client: settings.arguments as Clients,
        );
      case SIMS_REMOVE_DIALOG:
        return SimsRemoveView(
          sim: settings.arguments as Sims,
        );
      default:
        return Container();
    }
  }
}
