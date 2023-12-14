import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/services/radios.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class RadiosRepository {
  final RadiosService _radiosService;

  RadiosRepository({
    required RadiosService radiosService,
  }) : _radiosService = radiosService;

  Future<ResponsePagination<Radios>> getRadios(RequestParams params) async {
    final data = await _radiosService.getAll(params);

    return ResponsePagination.fromJson(
      data,
      Radios.fromJson,
    );
  }
}
