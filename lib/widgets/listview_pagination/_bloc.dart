part of 'sk_listview_pagination.dart';

class _ListPaginationBloc<T>
    extends SkBloc<ListPaginationState<T>, ListPaginationEvent> {
  final ApiProvider<T> _provider;

  _ListPaginationBloc({
    required ApiProvider<T> provider,
  })  : _provider = provider,
        super(ListPaginationLoading<T>());

  @override
  void onEvent(ListPaginationEvent event) {
    if (event is ListPaginationGetAll) {
      _getAll();
    } else if (event is ListPaginationGetNextPage) {
      _getNextPage();
    }
  }

  Future<void> _fetch(RequestParams params) async {
    try {
      final data = await _provider(params);

      final lastItems = state is ListPaginationLoaded<T>
          ? (state as ListPaginationLoaded<T>).items
          : [] as List<T>;

      emit(ListPaginationLoaded<T>(
        items: lastItems + data.items,
        page: data.page,
        totalPages: data.totalPages,
      ));
    } catch (e) {
      emitError(e);
    }
  }

  void _getAll() {
    emit(ListPaginationLoading<T>());

    _fetch({
      'page': 1,
    });
  }

  void _getNextPage() {
    final currentState = state;

    if (currentState is ListPaginationLoaded<T> &&
        currentState.page < currentState.totalPages) {
      _fetch({
        'page': currentState.page + 1,
      });
    }
  }
}

// State
abstract class ListPaginationState<T> {}

class ListPaginationLoading<T> extends ListPaginationState<T> {}

class ListPaginationLoaded<T> extends ListPaginationState<T> {
  ListPaginationLoaded({
    required this.items,
    required this.page,
    required this.totalPages,
  });

  final List<T> items;
  final int page;
  final int totalPages;
}

class ListPaginationError extends ListPaginationState {
  ListPaginationError({
    required this.error,
  });

  final String error;
}

// Events
abstract class ListPaginationEvent {}

class ListPaginationGetAll extends ListPaginationEvent {}

class ListPaginationGetNextPage extends ListPaginationEvent {}
