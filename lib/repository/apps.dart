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
}
