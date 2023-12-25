// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/views/clients/actions.dart';
import 'package:skyradio_mobile/views/clients/filter.dart';
import 'package:skyradio_mobile/views/radios/actions.dart';
import 'package:skyradio_mobile/views/radios/filter.dart';
import 'package:skyradio_mobile/views/sims/actions.dart';
import 'package:skyradio_mobile/views/sims/add.dart';
import 'package:skyradio_mobile/views/sims/filter.dart';
import 'package:skyradio_mobile/views/sims/profile.dart';
import 'package:skyradio_mobile/views/sims/swap.dart';
import 'package:skyradio_mobile/views/sort_list.dart';
import 'package:skyradio_mobile/views/radios/profile.dart';
import 'package:skyradio_mobile/widgets/bottom_sheet.dart';

const RADIO_BOTTOM_SHEET = '/radios';
const RADIOS_FILTER_BOTTOM_SHEET = '/radios_filter';
const RADIOS_ACTIONS_BOTTOM_SHEET = '/radios_actions';
const SIM_BOTTOM_SHEET = '/sims';
const SIMS_FILTER_BOTTOM_SHEET = '/sims_filter';
const SIMS_ACTIONS_BOTTOM_SHEET = '/sims_actions';
const CLIENTS_FILTER_BOTTOM_SHEET = '/clients_filter';
const SORT_LIST_BOTTOM_SHEET = '/clients_sort';
const CLIENTS_ACTIONS_BOTTOM_SHEET = '/clients_actions';
const SIMS_ADD_BOTTOM_SHEET = '/sims_add';
const SIMS_SWAP_BOTTOM_SHEET = '/sims_swap';

class BottomSheetGenerator {
  static Widget generate(RouteSettings settings) {
    switch (settings.name) {
      case RADIO_BOTTOM_SHEET:
        final radio = settings.arguments as Radios;

        return RadioView(radio: radio);
      case SIM_BOTTOM_SHEET:
        final sim = settings.arguments as Sims;

        return SimView(sim: sim);
      case SIMS_FILTER_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final filter = args['filter'] as SimsFilter;
        final onRefresh = args['onRefresh'] as VoidCallback;

        return SimsFilterView(
          filter: filter,
          onRefresh: onRefresh,
        );
      case CLIENTS_FILTER_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final filter = args['filter'] as ClientsFilter;
        final onRefresh = args['onRefresh'] as VoidCallback;

        return ClientsFilterView(
          filter: filter,
          onRefresh: onRefresh,
        );
      case SORT_LIST_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final sort = args['sort'] as ApiSortModel;
        final onRefresh = args['onRefresh'] as VoidCallback;

        return SortListView(
          sort: sort,
          onRefresh: onRefresh,
        );
      case CLIENTS_ACTIONS_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final client = args['client'] as Clients;
        final onRefresh = args['onRefresh'] as Function;

        return ClientsActionsView(client: client, onRefresh: onRefresh);
      case RADIOS_FILTER_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final filter = args['filter'] as RadiosFilter;
        final onRefresh = args['onRefresh'] as VoidCallback;

        return RadiosFilterView(
          filter: filter,
          onRefresh: onRefresh,
        );
      case RADIOS_ACTIONS_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final radio = args['radio'] as Radios;
        final onRefresh = args['onRefresh'] as Function;

        return RadiosActionsView(radio: radio, onRefresh: onRefresh);
      case SIMS_ACTIONS_BOTTOM_SHEET:
        final args = settings.arguments as Map<String, dynamic>;

        final sim = args['sim'] as Sims;
        final onRefresh = args['onRefresh'] as Function;

        return SimsActionsView(sim: sim, onRefresh: onRefresh);
      case SIMS_ADD_BOTTOM_SHEET:
        final args = settings.arguments;

        final radio = args is Radios ? args : null;
        final sim = args is Sims ? args : null;

        return AddSimsView(
          radio: radio ?? sim!.radio!,
          sim: sim,
        );

      case SIMS_SWAP_BOTTOM_SHEET:
        final radio = settings.arguments as Radios;

        return SwapSimsView(
          radio: radio,
          sim: radio.sim!,
        );
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
