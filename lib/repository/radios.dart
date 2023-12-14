import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/services/radios.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class RadiosRepository {
  final RadiosService _radiosService;

  RadiosRepository({
    required RadiosService radiosService,
  }) : _radiosService = radiosService;

  Future<ResponsePagination<Radios>> getRadios(
      Map<String, dynamic> params) async {
    final data = await _radiosService.getAll();

    return ResponsePagination.fromJson(
      data,
      Radios.fromJson,
    );
  }
}
