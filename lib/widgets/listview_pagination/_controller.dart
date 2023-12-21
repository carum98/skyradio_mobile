part of 'sk_listview_pagination.dart';

class SkListViewPaginationController<T> {
  final _ListPaginationBloc<T> _bloc;

  SkListViewPaginationController({
    required ApiProvider<T> provider,
    ApiParams? params,
  }) : _bloc = _ListPaginationBloc(
          provider: provider,
          params: params ?? ApiParams(),
        );

  get state => _bloc.state;
  get stream => _bloc.stream;
  get params => _bloc.params;

  void search(String query) {
    _bloc.onEvent(ListPaginationSearch(query));
  }

  void getAll() {
    _bloc.onEvent(ListPaginationGetAll());
  }

  void nextPage() {
    _bloc.onEvent(ListPaginationGetNextPage());
  }

  Future<void> refresh() async {
    await _bloc.onEvent(ListPaginationRefresh());
  }

  void filter(RequestParams filter) {
    _bloc.onEvent(ListPaginationFilter(filter));
  }

  void sort(RequestParams sort) {
    _bloc.onEvent(ListPaginationSort(sort));
  }

  dispose() {
    _bloc.dispose();
  }
}
