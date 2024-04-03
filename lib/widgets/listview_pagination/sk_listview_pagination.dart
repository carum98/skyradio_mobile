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
  final ScrollController? scrollController;
  final Widget Function(T item) builder;
  final void Function(T item)? onTap;
  final void Function(T item)? onLongPress;

  final bool handleBottomBarVisibility;
  final bool isSliver;

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
    this.scrollController,
    double? paddingTop,
    this.handleBottomBarVisibility = false,
  })  : paddingTop = paddingTop ?? 10,
        edgeOffset = paddingTop != null ? paddingTop - 20 : 0.0,
        isSliver = false;

  const SkListViewPagination.sliver({
    super.key,
    required this.scrollController,
    required this.controller,
    required this.builder,
    this.onTap,
    this.onLongPress,
    this.padding = 10,
  })  : paddingTop = 10,
        edgeOffset = 0.0,
        handleBottomBarVisibility = false,
        isSliver = true;

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

    _scrollController = widget.scrollController ?? ScrollController();

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

    // Only dispose the controller if not is sliver (provitional fix)
    if (!widget.isSliver) {
      _controller.dispose();
    }

    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSliver) {
      return _Builder<T>(
        stream: _controller.stream,
        padding: widget.padding,
        paddingTop: widget.paddingTop,
        isSliver: true,
        builder: (data) => _Data(
          scrollController: _scrollController,
          data: data,
          paddingTop: widget.paddingTop,
          padding: widget.padding,
          builder: widget.builder,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          isSliver: true,
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: _controller.refresh,
        edgeOffset: widget.edgeOffset,
        child: _Builder<T>(
          stream: _controller.stream,
          padding: widget.padding,
          paddingTop: widget.paddingTop,
          builder: (data) => _Data(
            scrollController: _scrollController,
            data: data,
            paddingTop: widget.paddingTop,
            padding: widget.padding,
            builder: widget.builder,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
          ),
        ),
      );
    }
  }
}

class _Builder<T> extends StatelessWidget {
  final Stream<ListPaginationState<T>> stream;
  final Widget Function(ListPaginationLoaded<T> data) builder;
  final double paddingTop;
  final double padding;
  final bool isSliver;

  const _Builder({
    required this.stream,
    required this.builder,
    required this.paddingTop,
    required this.padding,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return _Error(
            error: snapshot.error.toString(),
            isSliver: isSliver,
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data;

          if (data is ListPaginationLoading) {
            return _Loading(isSliver: isSliver);
          }

          if (data is ListPaginationEmpty) {
            return _Empty(
              isSliver: isSliver,
              paddingTop: paddingTop,
              padding: padding,
            );
          }

          if (data is ListPaginationLoaded) {
            return builder(data as ListPaginationLoaded<T>);
          }
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _Loading(isSliver: isSliver);
        }

        return const SizedBox();
      },
    );
  }
}

class _Error extends StatelessWidget {
  final String error;
  final bool isSliver;

  const _Error({
    required this.error,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: Text(error),
    );

    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}

class _Loading extends StatelessWidget {
  final bool isSliver;

  const _Loading({
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    const child = Center(
      child: CircularProgressIndicator(),
    );

    return isSliver ? const SliverToBoxAdapter(child: child) : child;
  }
}

class _Empty extends StatelessWidget {
  final double paddingTop;
  final double padding;
  final bool isSliver;

  const _Empty({
    required this.paddingTop,
    required this.padding,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      constraints: const BoxConstraints(maxHeight: 150),
      margin: EdgeInsets.only(
        top: paddingTop,
        left: padding,
        right: padding,
        bottom: padding,
      ),
      child: const Center(
        child: Text(
          'Sin resultados',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );

    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}

class _Data<T> extends StatelessWidget {
  final ScrollController scrollController;
  final ListPaginationLoaded<T> data;
  final double paddingTop;
  final double padding;
  final Widget Function(T item) builder;
  final void Function(T item)? onTap;
  final void Function(T item)? onLongPress;
  final bool isSliver;

  const _Data({
    super.key,
    required this.scrollController,
    required this.data,
    required this.paddingTop,
    required this.padding,
    required this.builder,
    this.onTap,
    this.onLongPress,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget separator = const SizedBox(height: 10);
    Widget itemBuilder(BuildContext _, int index) {
      final item = data.items[index];

      return InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!(item);
          }
        },
        onLongPress: () {
          if (onLongPress != null) {
            onLongPress!(item);
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
          child: builder(item),
        ),
      );
    }

    if (isSliver) {
      return SliverPadding(
        padding: EdgeInsets.only(
          top: paddingTop,
          left: padding,
          right: padding,
          bottom: padding,
        ),
        sliver: SliverList.separated(
          itemCount: data.items.length,
          separatorBuilder: (_, __) => separator,
          itemBuilder: itemBuilder,
        ),
      );
    } else {
      return ListView.separated(
        controller: scrollController,
        itemCount: data.items.length,
        padding: EdgeInsets.only(
          top: paddingTop,
          left: padding,
          right: padding,
          bottom: padding,
        ),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        separatorBuilder: (_, __) => separator,
        itemBuilder: itemBuilder,
      );
    }
  }
}
