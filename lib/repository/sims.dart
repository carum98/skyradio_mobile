import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/services/sims.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class SimsRepository {
  final SimsService _simsService;

  SimsRepository({
    required SimsService simsService,
  }) : _simsService = simsService;

  Future<ResponsePagination<Sims>> getSims(RequestParams params) async {
    final data = await _simsService.getAll(params);

    return ResponsePagination.fromJson(
      data,
      Sims.fromJson,
    );
  }

  Future<Sims> getSim(String code) async {
    final data = await _simsService.get(code);

    return Sims.fromJson(data);
  }

  Future<Sims> create(RequestParams params) async {
    final data = await _simsService.create(params);

    return Sims.fromJson(data);
  }

  Future<void> update(String code, RequestParams params) async {
    await _simsService.update(code, params);
  }

  Future<void> delete(String code) async {
    await _simsService.delete(code);
  }

  Future<void> addRadio(String code, RequestParams params) async {
    await _simsService.addRadio(code, params);
  }
}
