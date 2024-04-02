part of 'sk_tab.dart';

class SkTabView extends StatelessWidget {
  final SkTabController controller;
  final List<Widget> views;

  const SkTabView({
    super.key,
    required this.controller,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.index,
      builder: (_, value, child) => views[value],
    );
  }
}
