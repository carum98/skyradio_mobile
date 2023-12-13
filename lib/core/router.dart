// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/views/clients.dart';
import 'package:skyradio_mobile/views/home.dart';
import 'package:skyradio_mobile/views/login.dart';
import 'package:skyradio_mobile/views/radios.dart';
import 'package:skyradio_mobile/views/sims.dart';

const HOME_VIEW = '/home';
const LOGIN_VIEW = '/login';
const CLIENTS_VIEW = '/clients';
const RADIOS_VIEW = '/radios';
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
      case RADIOS_VIEW:
        return MaterialPageRoute(
          builder: (_) => const RadiosView(),
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
