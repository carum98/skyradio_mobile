import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/modality.dart';
import 'package:skyradio_mobile/models/models.dart';
import 'package:skyradio_mobile/models/providers.dart';
import 'package:skyradio_mobile/models/seller.dart';
import 'package:skyradio_mobile/services/common.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class CommonRepository {
  final CommonService _commonService;

  CommonRepository({
    required CommonService commonService,
  }) : _commonService = commonService;

  Future<ResponsePagination<Modality>> getModalities(
    RequestParams params,
  ) async {
    final data = await _commonService.getModalities(params);

    return ResponsePagination.fromJson(
      data,
      Modality.fromJson,
    );
  }

  Future<ResponsePagination<Models>> getModels(RequestParams params) async {
    final data = await _commonService.getModels(params);

    return ResponsePagination.fromJson(
      data,
      Models.fromJson,
    );
  }

  Future<ResponsePagination<Seller>> getSellers(RequestParams params) async {
    final data = await _commonService.getSellers(params);

    return ResponsePagination.fromJson(
      data,
      Seller.fromJson,
    );
  }

  Future<ResponsePagination<Providers>> getProviders(
      RequestParams params) async {
    final data = await _commonService.getProviders(params);

    return ResponsePagination.fromJson(
      data,
      Providers.fromJson,
    );
  }
}
