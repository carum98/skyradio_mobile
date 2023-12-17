// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/views/radio.dart';
import 'package:skyradio_mobile/views/sim.dart';
import 'package:skyradio_mobile/widgets/bottom_sheet.dart';

const RADIO_BOTTOM_SHEET = '/radios';
const SIM_BOTTOM_SHEET = '/sims';

class BottomSheetGenerator {
  static Widget generate(RouteSettings settings) {
    switch (settings.name) {
      case RADIO_BOTTOM_SHEET:
        final radio = settings.arguments as Radios;

        return RadioView(radio: radio);
      case SIM_BOTTOM_SHEET:
        final sim = settings.arguments as Sims;

        return SimView(sim: sim);
      default:
        return Container();
    }
  }
}

// ignore: must_be_immutable
class SkBottomSheet extends InheritedWidget {
  late BuildContext _context;

  SkBottomSheet({
    super.key,
    required Widget child,
  }) : super(child: child);

  Future<T?> pushNamed<T>(String name, {Object? arguments}) async {
    final settings = RouteSettings(
      name: name,
      arguments: arguments,
    );

    return skBottomSheet<T>(
      _context,
      BottomSheetGenerator.generate(settings),
    );
  }

  static SkBottomSheet of(BuildContext context) {
    final instance =
        context.dependOnInheritedWidgetOfExactType<SkBottomSheet>()!;

    instance._context = context;

    return instance;
  }

  @override
  bool updateShouldNotify(SkBottomSheet oldWidget) => false;
}