import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/license.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';

class Console {
  String code;
  License license;

  Console({
    required this.code,
    required this.license,
  });

  factory Console.fromJson(Map<String, dynamic> json) {
    return Console(
      code: json['code'],
      license: License.fromJson(json['license']),
    );
  }
}

class ConsoleForm extends SkFormModel {
  License? _license;

  ConsoleForm({
    super.code,
    License? license,
  }) : _license = license;

  License? get license => _license;

  set license(License? value) {
    _license = value;
    notifyListeners();
  }

  factory ConsoleForm.create() {
    return ConsoleForm();
  }

  factory ConsoleForm.update(Console console) {
    return ConsoleForm(
      code: console.code,
      license: console.license,
    );
  }

  @override
  RequestData getParams() {
    return {
      'license_code': license?.code,
    };
  }

  @override
  bool get isValid => license != null;
}
