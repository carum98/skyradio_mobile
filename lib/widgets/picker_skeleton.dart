import 'package:flutter/material.dart';

class PickerSkeleton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const PickerSkeleton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<PickerSkeleton> createState() => _PickerSkeletonState();
}

class _PickerSkeletonState extends State<PickerSkeleton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(15);

    final color = isTapped
        ? Theme.of(context).primaryColor.withOpacity(0.5)
        : Colors.grey.withOpacity(0.5);

    return CustomPaint(
      painter: _DottedBorderPainter(
        color: color,
        radius: radius,
      ),
      child: InkWell(
        onTap: widget.onPressed,
        onHighlightChanged: (value) {
          setState(() => isTapped = value);
        },
        borderRadius: const BorderRadius.all(radius),
        highlightColor: Colors.transparent,
        splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Ink(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(radius),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 18, color: color),
            ),
          ),
        ),
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final Radius radius;

  const _DottedBorderPainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const dottedLength = 5.5;
    const gapLength = 5.5;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radius,
      ));

    for (int i = 0; i < path.computeMetrics().length; i++) {
      final metric = path.computeMetrics().elementAt(i);
      final totalLength = metric.length;
      final dottedCount = (totalLength / (dottedLength + gapLength)).floor();

      for (int i = 0; i < dottedCount; i++) {
        final start = i * (dottedLength + gapLength);
        final end = start + dottedLength;

        canvas.drawPath(
          metric.extractPath(start, end, startWithMoveTo: true),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
