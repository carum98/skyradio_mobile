import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/services/sims.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

class SimsRepository {
  final SimsService _simsService;

  SimsRepository({
    required SimsService simsService,
  }) : _simsService = simsService;

  Future<ResponsePagination<Sims>> getSims(Map<String, dynamic> params) async {
    final data = await _simsService.getAll();

    return ResponsePagination.fromJson(
      data,
      Sims.fromJson,
    );
  }
}
