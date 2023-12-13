import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bloc.dart';

part '_bloc.dart';

class SkListViewPagination<T> extends StatefulWidget {
  final ListPaginationProvider<T> provider;
  final Widget Function(T item) builder;

  const SkListViewPagination({
    super.key,
    required this.provider,
    required this.builder,
  });

  @override
  State<SkListViewPagination> createState() => _SkListViewPaginationState<T>();
}

class _SkListViewPaginationState<T> extends State<SkListViewPagination<T>> {
  late final _ListPaginationBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = _ListPaginationBloc(
      provider: widget.provider,
    );

    _bloc.onEvent(ListPaginationGetAll());
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data;

          if (data is ListPaginationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (data is ListPaginationLoaded) {
            return ListView.builder(
              itemCount: data.items.length,
              itemBuilder: (_, index) => widget.builder(data.items[index]),
            );
          }
        }

        return const SizedBox();
      },
    );
  }
}
