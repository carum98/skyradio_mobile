import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/console.dart';
import 'package:skyradio_mobile/services/consoles.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class ConsolesRepository {
  final ConsolesService _consolesService;

  ConsolesRepository({
    required ConsolesService consolesService,
  }) : _consolesService = consolesService;

  Future<ResponsePagination<Console>> getApps(RequestParams params) async {
    final data = await _consolesService.getAll(params);

    return ResponsePagination.fromJson(
      data,
      Console.fromJson,
    );
  }

  Future<Console> getApp(String code) async {
    final data = await _consolesService.getConsole(code);

    return Console.fromJson(data);
  }

  Future<Console> create(String clientCode, RequestParams params) async {
    final data = await _consolesService.create(clientCode, params);

    return Console.fromJson(data);
  }

  Future<void> update(String code, RequestParams params) async {
    await _consolesService.update(code, params);
  }

  Future<void> delete(String code) async {
    await _consolesService.delete(code);
  }
}
