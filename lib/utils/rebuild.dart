import 'package:flutter/widgets.dart';

class RebuildController {
  final GlobalKey rebuildKey = GlobalKey();

  void rebuild() {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (rebuildKey.currentContext as Element).visitChildren(rebuild);
  }
}

class RebuildWrapper extends StatelessWidget {
  final RebuildController controller;
  final Widget child;

  const RebuildWrapper({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
        key: controller.rebuildKey,
        child: child,
      );
}
