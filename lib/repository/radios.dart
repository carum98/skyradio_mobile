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

  Future<Radios> getRadio(String code) async {
    final data = await _radiosService.get(code);

    return Radios.fromJson(data);
  }

  Future<Radios> create(RequestParams params) async {
    final data = await _radiosService.create(params);

    return Radios.fromJson(data);
  }

  Future<void> update(String code, RequestParams params) async {
    // Check if params is empty
    if (params.isEmpty) {
      // Prevent updating with empty params
      return;
    }

    await _radiosService.update(code, params);
  }

  Future<void> delete(String code) async {
    await _radiosService.delete(code);
  }

  Future<void> addSim(String code, RequestParams params) async {
    await _radiosService.addSim(code, params);
  }

  Future<void> swapSim(String code, RequestParams params) async {
    await _radiosService.swapSim(code, params);
  }

  Future<void> removeSim(String code) async {
    await _radiosService.removeSim(code);
  }

  Future<void> addClient(String code, RequestParams params) async {
    await _radiosService.addClient(code, params);
  }
}
