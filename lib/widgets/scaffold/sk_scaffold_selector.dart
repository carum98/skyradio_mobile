import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';
import 'package:skyradio_mobile/widgets/search_input.dart';

class SkScaffoldSelector<T> extends StatelessWidget {
  final SkListViewPaginationController<T> controller;
  final Widget Function(T) builder;

  const SkScaffoldSelector({
    super.key,
    required this.builder,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
            child: SkSearchInput(
              onChanged: controller.search,
            ),
          ),
        ),
      ),
      body: SkListViewPagination<T>(
        controller: controller,
        builder: builder,
        paddingTop: 190,
        onTap: (v) {
          Navigator.pop(context, v);
        },
      ),
    );
  }
}
