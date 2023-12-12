import 'dart:async';

import 'clients_bloc_event.dart';
import 'clients_bloc_state.dart';

export 'clients_bloc_event.dart';
export 'clients_bloc_state.dart';

import 'package:skyradio_mobile/repository/clients_repository.dart';

class ClientsBloc {
  final ClientsRepository _repository;
  final StreamController<ClientsBlocState> _controller;
  ClientsBlocState state = ClientsBlocLoading();

  ClientsBloc({
    required ClientsRepository repository,
  })  : _repository = repository,
        _controller = StreamController<ClientsBlocState>.broadcast() {
    _controller.stream.listen((value) => state = value);
  }

  Stream<ClientsBlocState> get stream => _controller.stream;

  onEvent(ClientsBlocEvent event) async {
    if (event is ClientsBlocGetAll) {
      await _getAll();
    }
  }

  Future<void> _getAll() async {
    _controller.add(ClientsBlocLoading());

    try {
      final data = await _repository.getClients();

      _controller.add(ClientsBlocLoaded(
        clients: data,
      ));
    } catch (e) {
      _controller.addError(e);
    }
  }

  dispose() {
    _controller.close();
  }
}
