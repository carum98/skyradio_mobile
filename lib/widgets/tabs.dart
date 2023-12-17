import 'package:flutter/material.dart';

class SkTab {
  final String label;
  final Widget child;

  SkTab({
    required this.label,
    required this.child,
  });
}

class SkTabs extends StatefulWidget {
  final List<SkTab> tabs;
  final double tabWidth;

  SkTabs({
    super.key,
    required this.tabs,
  }) : tabWidth = tabs
                .map((element) => element.label)
                .reduce((a, b) => a.length > b.length ? a : b)
                .length *
            12;

  @override
  State<SkTabs> createState() => _SkTabsState();
}

class _SkTabsState extends State<SkTabs> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(7),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                left: widget.tabWidth * index,
                top: 0,
                bottom: 0,
                child: Container(
                  width: widget.tabWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final tab in widget.tabs)
                    GestureDetector(
                      onTap: () {
                        setState(() => index = widget.tabs.indexOf(tab));
                      },
                      child: Container(
                        width: widget.tabWidth,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          tab.label,
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
            ],
          ),
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.tabs[index].child,
        ),
      ],
    );
  }
}
