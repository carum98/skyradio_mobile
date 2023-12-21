import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/search_input.dart';

enum SkScaffoldAction { add, filter, sort }

class SkScaffold<T> extends StatelessWidget {
  final ApiProvider<T> provider;
  final Widget Function(T) builder;
  final void Function(T)? onTap;
  final void Function(SkScaffoldAction, Function)? onListActions;
  final void Function(T, VoidCallback)? onItemActions;

  const SkScaffold({
    super.key,
    required this.title,
    required this.provider,
    required this.builder,
    this.onTap,
    this.onListActions,
    this.onItemActions,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController<T>(provider: provider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.transparent),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: SkSearchInput(
                    onChanged: controller.search,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    onListActions?.call(
                      SkScaffoldAction.filter,
                      controller.filter,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(45, 45),
                  ),
                  child: const SkIcon(SkIconData.filter, size: 20),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    onListActions?.call(
                      SkScaffoldAction.sort,
                      controller.sort,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(45, 45),
                  ),
                  child: const SkIcon(SkIconData.sort, size: 20),
                )
              ],
            ),
          ),
        ),
      ),
      body: SkListViewPagination<T>(
        controller: controller,
        builder: builder,
        paddingTop: 190,
        onTap: onTap,
        onLongPress: (item) {
          onItemActions?.call(item, controller.refresh);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onListActions?.call(
            SkScaffoldAction.add,
            controller.refresh,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
