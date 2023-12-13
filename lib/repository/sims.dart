import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/services/sims.dart';

class SimsRepository {
  final SimsService _simsService;

  SimsRepository({
    required SimsService simsService,
  }) : _simsService = simsService;

  Future<List<Sims>> getSims(Map<String, dynamic> params) async {
    final data = await _simsService.getAll();

    return data['data'].map<Sims>((sim) => Sims.fromJson(sim)).toList();
  }
}
