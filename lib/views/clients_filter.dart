import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/selectors/modalities.dart';
import 'package:skyradio_mobile/widgets/selectors/sellers.dart';

class ClientsFilterView extends StatelessWidget {
  final ClientsFilter filter;
  final Function(RequestParams) onFilter;

  const ClientsFilterView({
    super.key,
    required this.filter,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: [
        ModalitiesSelector(
          initialValue: filter.modality,
          onChanged: (value) {
            filter.modality = value;
            onFilter(filter.getParams());
          },
        ),
        SellersSelector(
          initialValue: filter.seller,
          onChanged: (value) {
            filter.seller = value;
            onFilter(filter.getParams());
          },
        ),
      ],
    );
  }
}
