import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/services/clients.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class ClientsRepository {
  final ClientsService _clientsService;

  ClientsRepository({
    required ClientsService clientsService,
  }) : _clientsService = clientsService;

  Future<ResponsePagination<Clients>> getClients(
      Map<String, dynamic> params) async {
    final data = await _clientsService.getAll();

    return ResponsePagination.fromJson(
      data,
      Clients.fromJson,
    );
  }
}
