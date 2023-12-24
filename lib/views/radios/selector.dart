import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_selector.dart';
import 'package:skyradio_mobile/widgets/tiles/radios.dart';

class RadiosSelectorView extends StatelessWidget {
  final RequestParams filters;

  const RadiosSelectorView({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).radiosRepository.getRadios,
      params: ApiParams(
        filter: _RadiosSelectorFilter(filters),
      ),
    );

    return SkScaffoldSelector(
      controller: controller,
      builder: (item) => RadiosTile(radio: item),
    );
  }
}

class _RadiosSelectorFilter extends ApiFilterModel {
  final RequestParams filters;
  _RadiosSelectorFilter(this.filters);

  @override
  RequestParams toRequestParams() => filters;
}
