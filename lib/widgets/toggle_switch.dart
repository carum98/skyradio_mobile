import 'package:flutter/material.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class SkToggleSwitch extends StatefulWidget {
  final SkIconData leftIcon;
  final SkIconData rightIcon;
  final ValueChanged<int> onChanged;

  const SkToggleSwitch({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
    required this.onChanged,
  });

  @override
  State<SkToggleSwitch> createState() => _SkToggleSwitchState();
}

class _SkToggleSwitchState extends State<SkToggleSwitch> {
  int index = 0;

  bool get isLeft => index == 0;
  bool get isRight => index == 1;

  final height = 40.0;
  final padding = 3.0;
  final borderRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => index = index == 0 ? 1 : 0);
        widget.onChanged(index);
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: isLeft ? padding : height + padding,
              top: padding,
              bottom: padding,
              child: Container(
                width: height - padding * 2,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: height,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Center(
                    child: SkIcon(
                      widget.leftIcon,
                      color: isLeft
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  width: height,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Center(
                    child: SkIcon(
                      widget.rightIcon,
                      color: isRight
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
