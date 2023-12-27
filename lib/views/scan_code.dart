import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWithScanWindow extends StatefulWidget {
  const BarcodeScannerWithScanWindow({super.key});

  @override
  State<BarcodeScannerWithScanWindow> createState() =>
      _BarcodeScannerWithScanWindowState();
}

class _BarcodeScannerWithScanWindowState
    extends State<BarcodeScannerWithScanWindow> {
  late MobileScannerController controller;

  ValueNotifier<BarcodeCapture?> capture = ValueNotifier(null);
  MobileScannerArguments? arguments;

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    capture.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            fit: BoxFit.contain,
            controller: controller,
            startDelay: true,
            onScannerStarted: (value) {
              arguments = value;
            },
            onDetect: (value) {
              capture.value = value;
            },
          ),
          ValueListenableBuilder(
            valueListenable: capture,
            builder: (_, value, __) {
              return (value != null && arguments != null)
                  ? CustomPaint(
                      painter: BarcodeOverlay(
                        barcode: value.barcodes.first,
                        arguments: arguments!,
                        capture: value,
                      ),
                    )
                  : Container();
            },
          )
        ],
      ),
    );
  }
}

class BarcodeOverlay extends CustomPainter {
  final BarcodeCapture capture;
  final Barcode barcode;
  final MobileScannerArguments arguments;

  BarcodeOverlay({
    required this.barcode,
    required this.arguments,
    required this.capture,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners.isEmpty) {
      return;
    }

    final adjustedSize = applyBoxFit(BoxFit.contain, arguments.size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final double ratioWidth;
    final double ratioHeight;

    if (!kIsWeb && Platform.isIOS) {
      ratioWidth = capture.size.width / adjustedSize.destination.width;
      ratioHeight = capture.size.height / adjustedSize.destination.height;
    } else {
      ratioWidth = arguments.size.width / adjustedSize.destination.width;
      ratioHeight = arguments.size.height / adjustedSize.destination.height;
    }

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final borderPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(cutoutPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
