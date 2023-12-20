import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/seller.dart';
import 'package:skyradio_mobile/widgets/basic_tile.dart';
import 'package:skyradio_mobile/widgets/select.dart';

class SellersSelector extends StatelessWidget {
  final Seller? initialValue;
  final Function(Seller) onChanged;

  const SellersSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SkSelect.label(
      label: 'Vendedor',
      placeholder: 'Vendedor',
      provider: DI.of(context).commonRepository.getSellers,
      itemBuilder: (item) => BasicTile(
        title: item.name,
      ),
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}
