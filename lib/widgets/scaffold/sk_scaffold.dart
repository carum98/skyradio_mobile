import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/listview_pagination/sk_listview_pagination.dart';

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
      appBar: AppBar(
        title: Text(title),
      ),
      body: SkListViewPagination<T>(
        provider: provider,
        builder: builder,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
