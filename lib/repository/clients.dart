import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/services/clients.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class ClientsRepository {
  final ClientsService _clientsService;

  ClientsRepository({
    required ClientsService clientsService,
  }) : _clientsService = clientsService;

  Future<ResponsePagination<Clients>> getClients(RequestParams params) async {
    final data = await _clientsService.getAll(params);

    return ResponsePagination.fromJson(
      data,
      Clients.fromJson,
    );
  }

  Future<ResponsePagination<Radios>> getRadios(
    String code,
    RequestParams params,
  ) async {
    final data = await _clientsService.getRadios(code, params);

    return ResponsePagination.fromJson(
      data,
      Radios.fromJson,
    );
  }

  Future<ResponsePagination<Apps>> getApps(
    String code,
    RequestParams params,
  ) async {
    final data = await _clientsService.getRadios(code, params);

    return ResponsePagination.fromJson(
      data,
      Apps.fromJson,
    );
  }

  Future<ClientsStats> getStats(String code) async {
    final data = await _clientsService.getStats(code);

    return ClientsStats.fromJson(data);
  }

  Future<Clients> get(String code) async {
    final data = await _clientsService.get(code);

    return Clients.fromJson(data);
  }

  Future<Clients> create(RequestParams params) async {
    final data = await _clientsService.create(params);

    return Clients.fromJson(data);
  }

  Future<void> update(String code, RequestParams params) async {
    await _clientsService.update(code, params);
  }

  Future<void> delete(String code) async {
    await _clientsService.delete(code);
  }

  Future<void> addRadio(String code, RequestParams params) async {
    await _clientsService.addRadios(code, params);
  }

  Future<void> removeRadio(String code, RequestParams params) async {
    await _clientsService.removeRadios(code, params);
  }

  Future<void> swapRadio(String code, RequestParams params) async {
    await _clientsService.swapRadio(code, params);
  }
}
