import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/services/radios.dart';

class RadiosRepository {
  final RadiosService _radiosService;

  RadiosRepository({
    required RadiosService radiosService,
  }) : _radiosService = radiosService;

  Future<List<Radios>> getRadios(Map<String, dynamic> params) async {
    final data = await _radiosService.getAll();

    return data['data'].map<Radios>((radio) => Radios.fromJson(radio)).toList();
  }
}
