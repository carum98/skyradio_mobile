// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/repository/apps.dart';
import 'package:skyradio_mobile/repository/clients.dart';
import 'package:skyradio_mobile/repository/radios.dart';
import 'package:skyradio_mobile/repository/sims.dart';
import 'package:skyradio_mobile/views/home.dart';

import 'bottom_sheet.dart';
import 'global_state.dart';

class DeepLinks {
  final _appLinks = AppLinks();

  final GlobalState _state;

  final ClientsRepository _clientsRepository;
  final RadiosRepository _radiosRepository;
  final SimsRepository _simsRepository;
  final AppsRepository _appsRepository;

  DeepLinks({
    required BuildContext context,
  })  : _state = DI.of(context).state,
        _clientsRepository = DI.of(context).clientsRepository,
        _radiosRepository = DI.of(context).radiosRepository,
        _simsRepository = DI.of(context).simsRepository,
        _appsRepository = DI.of(context).appsRepository {
    init();
  }

  NavigatorState? get _navigatorState => _state.navigatorKey.currentState;
  BuildContext? get _context => _state.navigatorKey.currentContext;

  Future<void> init() async {
    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();

    if (appLink != null) {
      _openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _appLinks.uriLinkStream.listen((uri) {
      _openAppLink(uri);
    });
  }

  void _openAppLink(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return;
    }

    final module = uri.pathSegments.first;

    switch (module) {
      case 'clients':
        _clients(uri);
        break;
      case 'radios':
        _radios(uri);
        break;
      case 'sims':
        _sims(uri);
        break;
      case 'apps':
        _apps(uri);
        break;
    }
  }

  Future<void> _clients(Uri uri) async {
    if (uri.pathSegments.length > 1) {
      final client = await _clientsRepository.get(uri.pathSegments[1]);

      _navigatorState?.pushNamed(
        CLIENT_VIEW,
        arguments: client,
      );
    } else {
      _navigatorState?.pushNamed(
        HOME_VIEW,
        arguments: HomeViewIndex.clients,
      );
    }
  }

  Future<void> _radios(Uri uri) async {
    if (uri.pathSegments.length > 1) {
      final radio = await _radiosRepository.getRadio(uri.pathSegments[1]);

      SkBottomSheet.of(_context!).pushNamed(
        RADIO_BOTTOM_SHEET,
        arguments: radio,
      );
    } else {
      _navigatorState?.pushNamed(
        HOME_VIEW,
        arguments: HomeViewIndex.radios,
      );
    }
  }

  Future<void> _sims(Uri uri) async {
    if (uri.pathSegments.length > 1) {
      final sim = await _simsRepository.getSim(uri.pathSegments[1]);

      SkBottomSheet.of(_context!).pushNamed(
        SIM_BOTTOM_SHEET,
        arguments: sim,
      );
    } else {
      _navigatorState?.pushNamed(
        HOME_VIEW,
        arguments: HomeViewIndex.sims,
      );
    }
  }

  Future<void> _apps(Uri uri) async {
    if (uri.pathSegments.length > 1) {
      final app = await _appsRepository.getApp(uri.pathSegments[1]);

      SkBottomSheet.of(_context!).pushNamed(
        APP_BOTTOM_SHEET,
        arguments: app,
      );
    } else {
      _navigatorState?.pushNamed(
        HOME_VIEW,
        arguments: HomeViewIndex.apps,
      );
    }
  }
}
