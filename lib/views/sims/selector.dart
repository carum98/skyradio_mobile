import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_selector.dart';
import 'package:skyradio_mobile/widgets/tiles/sims.dart';

class SimsSelectorView extends StatelessWidget {
  final RequestParams filters;

  const SimsSelectorView({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).simsRepository.getSims,
      params: ApiParams(
        filter: _SimsSelectorFilter(filters),
      ),
    );

    return SkScaffoldSelector(
      controller: controller,
      builder: (item) => SimsFormTile(sim: item),
    );
  }
}

class _SimsSelectorFilter extends ApiFilterModel {
  final RequestParams filters;
  _SimsSelectorFilter(this.filters);

  @override
  RequestParams toRequestParams() => filters;
}
