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
}
