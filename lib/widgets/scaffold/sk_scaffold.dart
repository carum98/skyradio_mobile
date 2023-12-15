import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

part '_actions_buttons.dart';
part '_search_input.dart';

class SkScaffold<T> extends StatelessWidget {
  final ApiProvider<T> provider;
  final Widget Function(T) builder;

  const SkScaffold({
    super.key,
    required this.title,
    required this.provider,
    required this.builder,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
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
                  child: _SearchInput(
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 10),
                _ActionsButtons(
                  onPressed: () {},
                  icon: Icons.filter_list_alt,
                ),
                const SizedBox(width: 10),
                _ActionsButtons(
                  onPressed: () {},
                  icon: Icons.sort,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SkListViewPagination<T>(
        provider: provider,
        builder: builder,
        paddingTop: 190,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
