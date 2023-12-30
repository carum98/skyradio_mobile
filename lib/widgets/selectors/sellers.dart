import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/seller.dart';
import 'package:skyradio_mobile/widgets/tiles/basic.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class SellersSelector extends StatelessWidget {
  final Seller? initialValue;
  final Function(Seller?) onChanged;
  final bool? showClearButton;

  const SellersSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.showClearButton,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect.label(
      label: 'Vendedor',
      placeholder: 'Vendedor',
      provider: DI.of(context).commonRepository.getSellers,
      showClearButton: showClearButton,
      itemBuilder: (item) => BasicTile(
        title: item.name,
      ),
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}
