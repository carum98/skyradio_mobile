import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_selector.dart';
import 'package:skyradio_mobile/widgets/tiles/clients.dart';

class ClientsSelectorView extends StatelessWidget {
  final RequestParams filters;

  const ClientsSelectorView({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController(
      provider: DI.of(context).clientsRepository.getClients,
      params: ApiParams(
        filter: _ClientsSelectorFilter(filters),
      ),
    );

    return SkScaffoldSelector(
      controller: controller,
      builder: (item) => ClientsTile(client: item),
    );
  }
}

class _ClientsSelectorFilter extends ApiFilterModel {
  final RequestParams filters;
  _ClientsSelectorFilter(this.filters);

  @override
  RequestParams toRequestParams() => filters;
}
