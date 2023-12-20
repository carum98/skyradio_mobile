part of 'sk_listview_pagination.dart';

class _ListPaginationBloc<T>
    extends SkBloc<ListPaginationState<T>, ListPaginationEvent> {
  final ApiProvider<T> _provider;

  _ListPaginationBloc({
    required ApiProvider<T> provider,
  })  : _provider = provider,
        super(ListPaginationLoading<T>());

  @override
  Future<void> onEvent(ListPaginationEvent event) async {
    if (event is ListPaginationGetAll) {
      await _getAll();
    } else if (event is ListPaginationGetNextPage) {
      await _getNextPage();
    } else if (event is ListPaginationRefresh) {
      await _refresh();
    }
  }

  Future<void> _fetch(RequestParams params, {List<T>? items}) async {
    try {
      final data = await _provider(params);

      emit(ListPaginationLoaded<T>(
        items: (items ?? []) + data.items,
        page: data.page,
        totalPages: data.totalPages,
      ));
    } catch (e) {
      emitError(e);
    }
  }

  Future<void> _getAll() async {
    emit(ListPaginationLoading<T>());

    await _fetch(
      {
        'page': 1,
      },
    );
  }

  Future<void> _getNextPage() async {
    final currentState = state;

    if (currentState is ListPaginationLoaded<T> &&
        currentState.page < currentState.totalPages) {
      await _fetch(
        {
          'page': currentState.page + 1,
        },
        items: currentState.items,
      );
    }
  }

  Future<void> _refresh() async {
    final currentState = state;

    if (currentState is ListPaginationLoaded<T>) {
      await _fetch(
        {
          'page': 1,
        },
      );
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

class ListPaginationRefresh extends ListPaginationEvent {}

class ListPaginationSearch extends ListPaginationEvent {
  final String query;
  ListPaginationSearch(this.query);
}
