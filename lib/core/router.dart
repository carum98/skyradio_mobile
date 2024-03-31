// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/console.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/views/apps/form.dart';
import 'package:skyradio_mobile/views/clients/form.dart';
import 'package:skyradio_mobile/views/clients/profile.dart';
import 'package:skyradio_mobile/views/clients/selector.dart';
import 'package:skyradio_mobile/views/consoles/form.dart';
import 'package:skyradio_mobile/views/home.dart';
import 'package:skyradio_mobile/views/login.dart';
import 'package:skyradio_mobile/views/radios/add.dart';
import 'package:skyradio_mobile/views/radios/form.dart';
import 'package:skyradio_mobile/views/radios/remove.dart';
import 'package:skyradio_mobile/views/radios/selector.dart';
import 'package:skyradio_mobile/views/radios/swap.dart';
import 'package:skyradio_mobile/views/sims/form.dart';
import 'package:skyradio_mobile/views/sims/selector.dart';

const HOME_VIEW = '/home';
const LOGIN_VIEW = '/login';

const CLIENT_VIEW = '/clients/:id';
const CLIENT_CREATE_VIEW = '/clients/create';
const CLIENT_UPDATE_VIEW = '/clients/:id/edit';
const CLIENT_SELECTOR_VIEW = '/clients/selector';

const RADIOS_CREATE_VIEW = '/radios/form';
const RADIOS_UPDATE_VIEW = '/radios/:id/edit';
const RADIOS_ADD_VIEW = '/radios/add';
const RADIOS_REMOVE_VIEW = '/radios/:id/remove';
const RADIOS_SELECTOR_VIEW = '/radios/selector';
const RADIOS_SWAP_VIEW = '/radios/swap';

const SIMS_CREATE_VIEW = '/sims/form';
const SIMS_UPDATE_VIEW = '/sims/:id/edit';
const SIMS_SELECTOR_VIEW = '/sims/selector';

const APPS_CREATE_VIEW = '/apps/form';
const APPS_UPDATE_VIEW = '/apps/:id/edit';

const CONSOLE_CREATE_VIEW = '/console/form';
const CONSOLE_UPDATE_VIEW = '/console/:id/edit';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case HOME_VIEW:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case LOGIN_VIEW:
        return MaterialPageRoute(
          builder: (_) => const Material(child: LoginView()),
        );

      case CLIENT_VIEW:
        final client = settings.arguments as Clients;

        return MaterialPageRoute(
          builder: (_) => ClientView(client: client),
        );
      case CLIENT_UPDATE_VIEW:
        final client = settings.arguments as Clients;

        return MaterialPageRoute(
          builder: (_) => ClientsFormView(model: ClientsForm.update(client)),
        );
      case CLIENT_CREATE_VIEW:
        final client = ClientsForm.create();

        return MaterialPageRoute(
          builder: (_) => ClientsFormView(model: client),
        );

      case RADIOS_CREATE_VIEW:
        final radio = RadiosForm.create();

        return MaterialPageRoute(
          builder: (_) => RadiosFormView(model: radio),
        );
      case RADIOS_UPDATE_VIEW:
        final radio = settings.arguments as Radios;

        return MaterialPageRoute(
          builder: (_) => RadiosFormView(model: RadiosForm.update(radio)),
        );

      case RADIOS_ADD_VIEW:
        final args = settings.arguments;

        final client = args is Clients ? args : null;
        final radio = args is Radios ? args : null;

        return MaterialPageRoute(
          builder: (_) => AddRadiosView(
            client: client ?? radio!.client!,
            radio: radio,
          ),
        );

      case RADIOS_REMOVE_VIEW:
        final args = settings.arguments;

        final client = args is Clients ? args : null;
        final radio = args is Radios ? args : null;

        return MaterialPageRoute(
          builder: (_) => RemoveRadiosView(
            client: client ?? radio!.client!,
            radio: radio,
          ),
        );

      case RADIOS_SWAP_VIEW:
        final args = settings.arguments;

        final client = args is Clients ? args : null;
        final radio = args is Radios ? args : null;

        return MaterialPageRoute(
          builder: (_) => SwapRadiosView(
            client: client ?? radio!.client!,
            radio: radio,
          ),
        );

      case RADIOS_SELECTOR_VIEW:
        final filters = settings.arguments as RequestParams;

        return MaterialPageRoute(
          builder: (_) => RadiosSelectorView(filters: filters),
        );

      case CLIENT_SELECTOR_VIEW:
        final filters = settings.arguments as RequestParams;

        return MaterialPageRoute(
          builder: (_) => ClientsSelectorView(filters: filters),
        );

      case SIMS_CREATE_VIEW:
        final sim = SimsForm.create();

        return MaterialPageRoute(
          builder: (_) => SimsFormView(model: sim),
        );

      case SIMS_UPDATE_VIEW:
        final sim = settings.arguments as Sims;

        return MaterialPageRoute(
          builder: (_) => SimsFormView(model: SimsForm.update(sim)),
        );

      case SIMS_SELECTOR_VIEW:
        final filters = settings.arguments as RequestParams;

        return MaterialPageRoute(
          builder: (_) => SimsSelectorView(filters: filters),
        );
      case APPS_CREATE_VIEW:
        final app = AppsForm.create();

        return MaterialPageRoute(
          builder: (_) => AppsFormView(model: app),
        );

      case APPS_UPDATE_VIEW:
        final app = settings.arguments as Apps;

        return MaterialPageRoute(
          builder: (_) => AppsFormView(model: AppsForm.update(app)),
        );

      case CONSOLE_CREATE_VIEW:
        final client = settings.arguments as Clients;
        final console = ConsoleForm.create();

        return MaterialPageRoute(
          builder: (_) => ConsoleFormView(model: console, client: client),
        );

      case CONSOLE_UPDATE_VIEW:
        final console = settings.arguments as Console;

        return MaterialPageRoute(
          builder: (_) => ConsoleFormView(model: ConsoleForm.update(console)),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
