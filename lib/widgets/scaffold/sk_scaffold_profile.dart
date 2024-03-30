import 'package:flutter/material.dart';

class SkScaffoldProfile<T> extends StatelessWidget {
  final ValueNotifier<T> item;
  final String title;
  final List<Widget> Function(T item) builder;
  final Function(T item, Function(T value)) onActions;

  SkScaffoldProfile({
    super.key,
    required T item,
    required this.title,
    required this.builder,
    required this.onActions,
  }) : item = ValueNotifier(item);

  @override
  Widget build(BuildContext context) {
    bool wasEdited = false;

    void onRefresh(T value) {
      wasEdited = true;
      item.value = value;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop(wasEdited);
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ValueListenableBuilder(
              valueListenable: item,
              builder: (_, value, __) => Wrap(
                runSpacing: 10,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  ...builder(value)
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                onActions(item.value, onRefresh);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(35, 35),
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              child: const Icon(Icons.more_vert, size: 25, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
