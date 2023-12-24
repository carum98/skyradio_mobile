// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/views/clients/form.dart';
import 'package:skyradio_mobile/views/clients/profile.dart';
import 'package:skyradio_mobile/views/clients/list.dart';
import 'package:skyradio_mobile/views/home.dart';
import 'package:skyradio_mobile/views/login.dart';
import 'package:skyradio_mobile/views/radios/add.dart';
import 'package:skyradio_mobile/views/radios/form.dart';
import 'package:skyradio_mobile/views/radios/list.dart';
import 'package:skyradio_mobile/views/radios/remove.dart';
import 'package:skyradio_mobile/views/radios/selector.dart';
import 'package:skyradio_mobile/views/radios/swap.dart';
import 'package:skyradio_mobile/views/sims/form.dart';
import 'package:skyradio_mobile/views/sims/list.dart';

const HOME_VIEW = '/home';
const LOGIN_VIEW = '/login';

const CLIENTS_VIEW = '/clients';
const CLIENT_VIEW = '/clients/:id';
const CLIENT_CREATE_VIEW = '/clients/create';
const CLIENT_UPDATE_VIEW = '/clients/:id/edit';

const RADIOS_VIEW = '/radios';
const RADIOS_CREATE_VIEW = '/radios/form';
const RADIOS_UPDATE_VIEW = '/radios/:id/edit';
const RADIOS_ADD_VIEW = '/radios/add';
const RADIOS_REMOVE_VIEW = '/radios/:id/remove';
const RADIOS_SELECTOR_VIEW = '/radios/selector';
const RADIOS_SWAP_VIEW = '/radios/swap';

const SIMS_VIEW = '/sims';
const SIMS_CREATE_VIEW = '/sims/form';
const SIMS_UPDATE_VIEW = '/sims/:id/edit';

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
      case CLIENTS_VIEW:
        return MaterialPageRoute(
          builder: (_) => const ClientsView(),
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
      case RADIOS_VIEW:
        return MaterialPageRoute(
          builder: (_) => const RadiosView(),
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
        final client = settings.arguments as Clients;

        return MaterialPageRoute(
          builder: (_) => AddRadiosView(client: client),
        );

      case RADIOS_REMOVE_VIEW:
        final client = settings.arguments as Clients;

        return MaterialPageRoute(
          builder: (_) => RemoveRadiosView(client: client),
        );

      case RADIOS_SWAP_VIEW:
        final client = settings.arguments as Clients;

        return MaterialPageRoute(
          builder: (_) => SwapRadiosView(client: client),
        );

      case RADIOS_SELECTOR_VIEW:
        final filters = settings.arguments as RequestParams;

        return MaterialPageRoute(
          builder: (_) => RadiosSelectorView(filters: filters),
        );
      case SIMS_VIEW:
        return MaterialPageRoute(
          builder: (_) => const SimsView(),
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
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
