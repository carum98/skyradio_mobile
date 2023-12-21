import 'package:skyradio_mobile/core/types.dart';

class ApiParams {
  final ApiBaseModel base = ApiBaseModel(page: 1);
  final ApiFilterModel? filter;
  final ApiSortModel? sort;

  ApiParams({
    this.filter,
    this.sort,
  });

  RequestParams toRequestParams() {
    final RequestParams params = {};

    params.addAll(base.toRequestParams());

    if (filter != null) {
      params.addAll(filter!.toRequestParams());
    }

    if (sort != null) {
      params.addAll(sort!.toRequestParams());
    }

    return params;
  }
}

class ApiBaseModel {
  int page;
  String? search;

  ApiBaseModel({
    required this.page,
    this.search,
  });

  RequestParams toRequestParams() {
    return {
      'page': page,
      if (search != null) 'search': search,
    };
  }
}

abstract class ApiFilterModel {
  RequestParams toRequestParams();
}

class ApiSortModel {
  String field = 'created_at';
  String order = 'desc';

  RequestParams toRequestParams() {
    return {
      'sort_by': field,
      'sort_order': order,
    };
  }
}
