part of 'sk_tab.dart';

class SkTabBar extends StatelessWidget {
  final SkTabController controller;
  final List<String> tabs;
  final double tabWidth;

  SkTabBar({
    super.key,
    SkTabController? controller,
    required this.tabs,
  })  : controller = controller ?? SkTabController(),
        tabWidth =
            tabs.reduce((a, b) => a.length > b.length ? a : b).length * 12;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(7),
          child: ValueListenableBuilder(
            valueListenable: controller.index,
            builder: (_, value, child) => Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  left: tabWidth * value,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: tabWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child!,
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final label in tabs)
                  GestureDetector(
                    onTap: () {
                      controller.setIndex(tabs.indexOf(label));
                    },
                    child: Container(
                      width: tabWidth,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
