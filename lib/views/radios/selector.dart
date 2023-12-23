import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_selector.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';

class RadiosSelectorView extends StatelessWidget {
  final List<Radios> valuesSelected;

  const RadiosSelectorView({
    super.key,
    required this.valuesSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).radiosRepository.getRadios,
      params: ApiParams(
        filter: RadiosSelectorFilter(
          radios: valuesSelected,
        ),
      ),
    );

    return SkScaffoldSelector(
      controller: controller,
      builder: (item) => RadiosTile(radio: item),
    );
  }
}
