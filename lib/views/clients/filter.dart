import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/selectors/modalities.dart';
import 'package:skyradio_mobile/widgets/selectors/sellers.dart';

class ClientsFilterView extends StatelessWidget {
  final ClientsFilter filter;
  final VoidCallback onRefresh;

  const ClientsFilterView({
    super.key,
    required this.filter,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: [
        ModalitiesSelector(
          initialValue: filter.modality,
          showClearButton: true,
          onChanged: (value) {
            filter.modality = value;
            onRefresh();
          },
        ),
        SellersSelector(
          initialValue: filter.seller,
          showClearButton: true,
          onChanged: (value) {
            filter.seller = value;
            onRefresh();
          },
        ),
      ],
    );
  }
}
