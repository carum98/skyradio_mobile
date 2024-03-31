import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/license.dart';
import 'package:skyradio_mobile/services/license.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class LicenseRepository {
  final LicenseService _licenseService;

  LicenseRepository({
    required LicenseService licenseService,
  }) : _licenseService = licenseService;

  Future<ResponsePagination<License>> getLicenses(RequestParams params) async {
    final data = await _licenseService.getAll(params);

    return ResponsePagination.fromJson(
      data,
      License.fromJson,
    );
  }

  Future<License> getLicense(String code) async {
    final data = await _licenseService.getLicense(code);

    return License.fromJson(data);
  }

  Future<License> create(RequestParams params) async {
    final data = await _licenseService.create(params);

    return License.fromJson(data);
  }

  Future<void> update(String code, RequestParams params) async {
    await _licenseService.update(code, params);
  }
}
