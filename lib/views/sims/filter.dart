import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/widgets/label.dart';
import 'package:skyradio_mobile/widgets/selectors/providers.dart';

class SimsFilterView extends StatelessWidget {
  final SimsFilter filter;
  final VoidCallback onRefresh;

  const SimsFilterView({
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
