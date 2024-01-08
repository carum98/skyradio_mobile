import 'dart:ui';

import 'package:flutter/material.dart' hide SwitchTheme;
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/icons.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/logo.dart';
import 'package:skyradio_mobile/widgets/logout_dropdown.dart';
import 'package:skyradio_mobile/widgets/search_input.dart';
import 'package:skyradio_mobile/widgets/switch_theme.dart';

enum SkScaffoldAction { add, filter, sort }

class SkScaffold<T> extends StatelessWidget {
  final SkListViewPaginationController<T> controller;
  final Widget Function(T) builder;
  final void Function(T)? onTap;
  final void Function(SkScaffoldAction)? onListActions;
  final void Function(T)? onItemActions;

  SkScaffold({
    super.key,
    required this.title,
    required this.builder,
    this.onTap,
    this.onListActions,
    this.onItemActions,
    ApiProvider<T>? provider,
    SkListViewPaginationController<T>? controller,
  })  : assert(provider != null || controller != null),
        controller =
            controller ?? SkListViewPaginationController(provider: provider!);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: SkLogo(size: 30),
        ),
        title: Text(title),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.transparent),
          ),
        ),
        actions: const [
          SwitchTheme(),
          SizedBox(width: 10),
          LogoutDropdown(),
          SizedBox(width: 10),
        ],
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
                    onListActions?.call(SkScaffoldAction.filter);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(45, 45),
                  ),
                  child: const SkIcon(SkIconData.filter, size: 20),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    onListActions?.call(SkScaffoldAction.sort);
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
        paddingTop: MediaQuery.of(context).padding.top + kToolbarHeight + 75,
        onTap: onTap,
        onLongPress: onItemActions,
        handleBottomBarVisibility: true,
      ),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom - 10),
        child: FloatingActionButton(
          onPressed: () {
            onListActions?.call(SkScaffoldAction.add);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
