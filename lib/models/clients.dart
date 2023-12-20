import 'dart:ui';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/utils/color.dart';

import 'modality.dart';
import 'seller.dart';

class Clients {
  final String code;
  final String name;
  final Color color;
  final Modality modality;
  final Seller? seller;
  final int radiosCount;

  Clients({
    required this.code,
    required this.name,
    required this.color,
    required this.modality,
    required this.seller,
    required this.radiosCount,
  });

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      code: json['code'],
      name: json['name'],
      color: (json['color'] as String).toColor(),
      modality: Modality.fromJson(json['modality']),
      seller: json['seller'] != null ? Seller.fromJson(json['seller']) : null,
      radiosCount: json['radios_count'],
    );
  }

  factory Clients.fromJsonSim(Map<String, dynamic> json) {
    return Clients(
      code: json['code'],
      name: json['name'],
      color: (json['color'] as String).toColor(),
      modality: Modality.placeholder(),
      seller: null,
      radiosCount: 0,
    );
  }
}

typedef StatsItem = ({
  String name,
  int count,
  double percent,
  Color color,
});

class ClientsStats {
  final List<StatsItem> models;
  final List<StatsItem> providers;

  ClientsStats({
    required this.models,
    required this.providers,
  });

  factory ClientsStats.fromJson(Map<String, dynamic> json) {
    final models = json['models'] as List;
    final providers = json['sims_providers'] as List;

    final modelsTotal =
        models.fold<int>(0, (sum, model) => sum + model['count'] as int);
    final providersTotal = providers.fold<int>(
        0, (sum, provider) => sum + provider['count'] as int);

    final modelsStats = models.map((e) {
      return (
        name: e['name'],
        count: e['count'],
        percent: e['count'] / modelsTotal * 100,
        color: (e['color'] as String).toColor(),
      ) as StatsItem;
    }).toList();

    final providersStats = providers.map((e) {
      return (
        name: e['name'],
        count: e['count'],
        percent: e['count'] / providersTotal * 100,
        color: (e['color'] as String).toColor(),
      ) as StatsItem;
    }).toList();

    return ClientsStats(
      models: modelsStats,
      providers: providersStats,
    );
  }
}

class ClientsForm {
  String? name;
  Color? color;
  Modality? modality;
  Seller? seller;

  ClientsForm({
    this.name,
    this.color,
    this.modality,
    this.seller,
  });

  factory ClientsForm.create() {
    return ClientsForm();
  }

  factory ClientsForm.update(Clients client) {
    return ClientsForm(
      name: client.name,
      color: client.color,
      modality: client.modality,
      seller: client.seller,
    );
  }

  RequestData toRequestData() {
    return {
      'name': name,
      'color': color?.toHex(),
      'modality_code': modality?.code,
      'seller_code': seller?.code,
    };
  }

  bool get isValid => name != null && color != null && modality != null;
}
