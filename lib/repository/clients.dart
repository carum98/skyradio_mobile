import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/services/clients.dart';

class ClientsRepository {
  final ClientsService _clientsService;

  ClientsRepository({
    required ClientsService clientsService,
  }) : _clientsService = clientsService;

  Future<List<Clients>> getClients(Map<String, dynamic> params) async {
    final data = await _clientsService.getAll();

    return data['data']
        .map<Clients>((client) => Clients.fromJson(client))
        .toList();
  }
}
