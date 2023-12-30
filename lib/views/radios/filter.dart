import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/widgets/label.dart';
import 'package:skyradio_mobile/widgets/selectors/models.dart';
import 'package:skyradio_mobile/widgets/selectors/providers.dart';

class RadiosFilterView extends StatelessWidget {
  final RadiosFilter filter;
  final VoidCallback onRefresh;

  const RadiosFilterView({
    super.key,
    required this.filter,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: [
        SkLabel(
          label: 'Modelo',
          child: ModelsSelectors(
            initialValue: filter.model,
            showClearButton: true,
            onChanged: (value) {
              filter.model = value;
              onRefresh();
            },
          ),
        ),
        SkLabel(
          label: 'Proveedor',
          child: ProvidersSelector(
            initialValue: filter.simProvider,
            showClearButton: true,
            onChanged: (value) {
              filter.simProvider = value;
              onRefresh();
            },
          ),
        ),
      ],
    );
  }
}
