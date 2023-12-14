import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

typedef ResponseData = Map<String, dynamic>;

typedef RequestData = Map<String, dynamic>;

typedef RequestParams = Map<String, dynamic>;

typedef ApiProvider<T> = Future<ResponsePagination<T>> Function(
  RequestParams params,
);
