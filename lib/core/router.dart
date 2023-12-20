// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/views/client.dart';
import 'package:skyradio_mobile/views/client_form.dart';
import 'package:skyradio_mobile/views/clients.dart';
import 'package:skyradio_mobile/views/home.dart';
import 'package:skyradio_mobile/views/login.dart';
import 'package:skyradio_mobile/views/radios.dart';
import 'package:skyradio_mobile/views/radios_form.dart';
import 'package:skyradio_mobile/views/sims.dart';

const HOME_VIEW = '/home';
const LOGIN_VIEW = '/login';
const CLIENTS_VIEW = '/clients';
const CLIENT_VIEW = '/clients/:id';
const CLIENT_FORM_VIEW = '/clients/form';
const RADIOS_VIEW = '/radios';
const RADIOS_FORM_VIEW = '/radios/form';
const SIMS_VIEW = '/sims';

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
      case CLIENT_FORM_VIEW:
        return MaterialPageRoute(
          builder: (_) => const ClientsFormView(),
        );
      case RADIOS_VIEW:
        return MaterialPageRoute(
          builder: (_) => const RadiosView(),
        );
      case RADIOS_FORM_VIEW:
        return MaterialPageRoute(
          builder: (_) => const RadiosFormView(),
        );
      case SIMS_VIEW:
        return MaterialPageRoute(
          builder: (_) => const SimsView(),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
