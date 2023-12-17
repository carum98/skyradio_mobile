import 'dart:math';

import 'package:flutter/material.dart';

class SkChart extends StatelessWidget {
  final List<SkChartData> data;
  final double size;

  SkChart({
    required this.data,
    required this.size,
  }) : super(key: Key('${Random().nextInt(1000)}'));

  @override
  Widget build(BuildContext context) {
    return PieChart(
      data: data,
      strokeWidth: 20,
      size: size,
    );
  }
}

class SkChartData {
  const SkChartData(this.label, this.color, this.count, this.percent);

  final String label;
  final Color color;
  final int count;
  final double percent;
}

class PieChart extends StatelessWidget {
  PieChart({
    required this.data,
    required this.size,
    this.strokeWidth = 8,
    Key? key,
  })  : // make sure sum of data is never ovr 100 percent
        assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100),
        super(key: key);

  final List<SkChartData> data;
  final double strokeWidth;
  final double size;

  @override
  Widget build(context) {
    return GestureDetector(
      onTapDown: (details) {
        showMenuWidget(
          context,
          offset: details.globalPosition,
          child: _SkChartInfo(data: data),
        );
      },
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _Painter(strokeWidth, data),
        ),
      ),
    );
  }
}

class _PainterData {
  const _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _Painter extends CustomPainter {
  _Painter(double strokeWidth, List<SkChartData> data) {
    dataList = data
        .map((e) => _PainterData(
              Paint()
                ..color = e.color
                ..style = PaintingStyle.stroke
                ..strokeCap = StrokeCap.round
                ..strokeWidth = strokeWidth,
              (e.percent - _padding) * _percentInRadians,
            ))
        .toList();
  }

  static const _percentInRadians = 0.062831853071796;
  static const _padding = 8;
  static const _paddingInRadians = _percentInRadians * _padding;
  static const _startAngle = -1.570796 + _paddingInRadians / 2;

  late final List<_PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // keep track of start angle for next stroke
    double startAngle = _startAngle;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians);

      startAngle += data.radians + _paddingInRadians;

      canvas.drawPath(path, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _SkChartInfo extends StatelessWidget {
  final List<SkChartData> data;

  const _SkChartInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final data in data)
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '${data.label}: ${data.count}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
      ],
    );
  }
}

Future<T?> showMenuWidget<T>(
  BuildContext context, {
  required Offset offset,
  required Widget child,
}) async {
  final position = RelativeRect.fromLTRB(
    offset.dx,
    offset.dy,
    MediaQuery.of(context).size.width - offset.dx,
    MediaQuery.of(context).size.height - offset.dy,
  );

  return await showMenu<T>(
    context: context,
    position: position,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    items: [
      PopupMenuItem(child: child),
    ],
  );
}
