import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bloc.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/utils/api_params.dart';

part '_bloc.dart';
part '_controller.dart';
part '_response_list.dart';

class SkListViewPagination<T> extends StatefulWidget {
  final SkListViewPaginationController<T> controller;
  final Widget Function(T item) builder;
  final void Function(T item)? onTap;
  final void Function(T item)? onLongPress;
  final bool handleBottomBarVisibility;

  final double paddingTop;
  final double edgeOffset;
  final double padding;

  const SkListViewPagination({
    super.key,
    required this.controller,
    required this.builder,
    this.padding = 10,
    this.onTap,
    this.onLongPress,
    double? paddingTop,
    this.handleBottomBarVisibility = false,
  })  : paddingTop = paddingTop ?? 10,
        edgeOffset = paddingTop != null ? paddingTop - 20 : 0.0;

  @override
  State<SkListViewPagination> createState() => _SkListViewPaginationState<T>();
}

class _SkListViewPaginationState<T> extends State<SkListViewPagination<T>> {
  late final SkListViewPaginationController<T> _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;

    _scrollController = ScrollController();

    _controller.getAll();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _controller.nextPage();
      }

      if (widget.handleBottomBarVisibility) {
        final state = DI.of(context).state;

        if (_scrollController.position.pixels >= 20) {
          if (state.showBottomBar) {
            state.setShowBottomBar(false);
          }
        } else {
          if (!state.showBottomBar) {
            state.setShowBottomBar(true);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _controller.refresh,
      edgeOffset: widget.edgeOffset,
      child: StreamBuilder(
        stream: _controller.stream,
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
              return ListView.separated(
                controller: _scrollController,
                itemCount: data.items.length,
                padding: EdgeInsets.only(
                  top: widget.paddingTop,
                  left: widget.padding,
                  right: widget.padding,
                  bottom: widget.padding,
                ),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final item = data.items[index] as T;

                  return InkWell(
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!(item);
                      }
                    },
                    onLongPress: () {
                      if (widget.onLongPress != null) {
                        widget.onLongPress!(item);
                      }
                    },
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: widget.builder(item),
                    ),
                  );
                },
              );
            }
          }

          return const SizedBox();
        },
      ),
    );
  }
}
