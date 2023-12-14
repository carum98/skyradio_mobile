import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bloc.dart';

part '_bloc.dart';
part '_response_list.dart';

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
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _bloc = _ListPaginationBloc(
      provider: widget.provider,
    );

    _scrollController = ScrollController();

    _bloc.onEvent(ListPaginationGetAll());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.onEvent(ListPaginationGetNextPage());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
    _scrollController.dispose();
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
              controller: _scrollController,
              itemCount: data.items.length,
              padding: const EdgeInsets.all(15),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (_, index) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: widget.builder(data.items[index]),
              ),
            );
          }
        }

        return const SizedBox();
      },
    );
  }
}
