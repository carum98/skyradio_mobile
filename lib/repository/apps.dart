import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/apps.dart';
import 'package:skyradio_mobile/services/apps.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class AppsRepository {
  final AppsService _appsService;

  AppsRepository({
    required AppsService appsService,
  }) : _appsService = appsService;

  Future<ResponsePagination<Apps>> getApps(RequestParams params) async {
    final data = await _appsService.getAll(params);

    return ResponsePagination.fromJson(
      data,
      Apps.fromJson,
    );
  }

  Future<Apps> getApp(String code) async {
    final data = await _appsService.getApp(code);

    return Apps.fromJson(data);
  }

  Future<Apps> create(RequestParams params) async {
    final data = await _appsService.create(params);

    return Apps.fromJson(data);
  }

  Future<void> update(String code, RequestParams params) async {
    await _appsService.update(code, params);
  }

  Future<void> delete(String code) async {
    await _appsService.delete(code);
  }
}
