part of 'sk_listview_pagination.dart';

class SkListViewPaginationController<T> {
  final _ListPaginationBloc<T> _bloc;

  SkListViewPaginationController({
    required ApiProvider<T> provider,
  }) : _bloc = _ListPaginationBloc(provider: provider);

  get state => _bloc.state;
  get stream => _bloc.stream;

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

  dispose() {
    _bloc.dispose();
  }
}
