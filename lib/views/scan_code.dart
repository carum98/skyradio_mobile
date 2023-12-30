import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeView extends StatefulWidget {
  const ScanCodeView({super.key});

  @override
  State<ScanCodeView> createState() => _ScanCodeViewState();
}

class _ScanCodeViewState extends State<ScanCodeView> {
  late MobileScannerController controller;

  final ValueNotifier<String?> _text = ValueNotifier<String?>(null);
  final ValueNotifier<BarcodeCapture?> capture = ValueNotifier(null);
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
    _text.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: Offset(
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 4,
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
    );

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        MobileScanner(
          fit: BoxFit.cover,
          controller: controller,
          scanWindow: scanWindow,
          startDelay: true,
          onScannerStarted: (value) {
            arguments = value;
          },
          onDetect: (value) {
            capture.value = value;
            _text.value = value.barcodes.first.displayValue;
          },
        ),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: ScannerOverlay(scanWindow),
        ),
        ValueListenableBuilder(
          valueListenable: _text,
          builder: (_, value, __) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: value == null ? -50 : 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    value ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: _text,
          builder: (_, value, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              bottom: value == null ? -50 : 10,
              child: child!,
            );
          },
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(_text.value),
            child: const Text(
              'Insertar',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanWindow, const Radius.circular(10)),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(cutoutPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
