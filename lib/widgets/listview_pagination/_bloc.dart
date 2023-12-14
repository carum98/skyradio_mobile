part of 'sk_listview_pagination.dart';

typedef ListPaginationProvider<T> = Future<ResponsePagination<T>> Function(
  Map<String, dynamic> params,
);

class _ListPaginationBloc<T>
    extends SkBloc<ListPaginationState<T>, ListPaginationEvent> {
  final ListPaginationProvider<T> _provider;

  _ListPaginationBloc({
    required ListPaginationProvider<T> provider,
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

  Future<void> _getAll() async {
    emit(ListPaginationLoading<T>());

    try {
      final data = await _provider({
        'page': 1,
      });

      emit(ListPaginationLoaded<T>(
        items: data.items,
        page: data.page,
        totalPages: data.totalPages,
      ));
    } catch (e) {
      emitError(e);
    }
  }

  Future<void> _getNextPage() async {
    final currentState = state;

    if (currentState is ListPaginationLoaded<T>) {
      if (currentState.page < currentState.totalPages) {
        emit(ListPaginationLoading<T>());

        try {
          final data = await _provider({
            'page': currentState.page + 1,
          });

          emit(ListPaginationLoaded<T>(
            items: currentState.items + data.items,
            page: currentState.page + 1,
            totalPages: currentState.totalPages,
          ));
        } catch (e) {
          emitError(e);
        }
      }
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
