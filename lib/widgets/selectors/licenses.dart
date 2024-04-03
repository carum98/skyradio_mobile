import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/license.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class LicenseSelector extends StatelessWidget {
  final License? initialValue;
  final Function(License?) onChanged;
  final bool? showClearButton;
  final bool? isRequired;

  const LicenseSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.showClearButton,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect(
      placeholder: 'Licencia',
      provider: DI.of(context).licenseRepository.getLicenses,
      showClearButton: showClearButton,
      initialValue: initialValue,
      isRequired: isRequired ?? false,
      itemBuilder: (item) => BasicTile(
        title: item.key,
      ),
      onChanged: onChanged,
      onEmptyCreate: (value) async {
        final license = await DI.of(context).licenseRepository.create({
          "key": value,
        });

        return license;
      },
    );
  }
}
