import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScanTextView extends StatefulWidget {
  const ScanTextView({super.key});

  @override
  State<ScanTextView> createState() => _ScanTextViewState();
}

class _ScanTextViewState extends State<ScanTextView> {
  bool _isBusy = false;

  CameraController? _controller;
  late final List<CameraDescription> _cameras;
  late final TextRecognizer _textRecognizer;

  final ValueNotifier<String?> _text = ValueNotifier<String?>(null);
  final _blocks = ValueNotifier<RecognizedText?>(null);

  @override
  void initState() {
    super.initState();
    startLiveFeed();
  }

  @override
  void dispose() {
    super.dispose();

    _controller?.dispose();
    _textRecognizer.close();
    _blocks.dispose();
    _text.dispose();
  }

  Future<void> startLiveFeed() async {
    _textRecognizer = TextRecognizer();

    _cameras = await availableCameras();

    _controller = CameraController(
      _cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888, // for iOS
    );

    await _controller!.initialize();
    if (!mounted) {
      return;
    }

    _controller?.startImageStream(_processCameraImage);

    setState(() {});
  }

  Future<void> _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();

    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final imageRotation = InputImageRotationValue.fromRawValue(
      _cameras.first.sensorOrientation,
    );
    if (imageRotation == null) return;

    final inputImageFormat = InputImageFormatValue.fromRawValue(
      image.format.raw,
    );
    if (inputImageFormat == null) return;

    if (image.planes.length != 1) return;
    final plane = image.planes.first;

    final planeData = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation, // used only in Android
      format: inputImageFormat, // used only in iOS
      bytesPerRow: plane.bytesPerRow, // used only in iOS
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, metadata: planeData);

    await processImage(inputImage);
  }

  Future<void> processImage(InputImage inputImage) async {
    if (_isBusy) return;
    _isBusy = true;

    final recognizedText = await _textRecognizer.processImage(inputImage);

    if (recognizedText.text.isNotEmpty) {
      _text.value = recognizedText.text;
      _blocks.value = recognizedText;
    }

    Future.delayed(const Duration(milliseconds: 900)).then((value) {
      _isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller?.value.isInitialized != true) {
      return Container();
    }

    final size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: 1,
              child: CameraPreview(_controller!),
            ),
          ),
        ),
        ValueListenableBuilder<RecognizedText?>(
          valueListenable: _blocks,
          builder: (_, value, __) {
            if (value == null) {
              return Container();
            }

            return CustomPaint(
              size: size,
              painter: ScanTextPainter(
                blocks: value.blocks,
                absoluteImageSize: Size(
                  _controller!.value.previewSize!.height,
                  _controller!.value.previewSize!.width,
                ),
              ),
            );
          },
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

class ScanTextPainter extends CustomPainter {
  final List<TextBlock> blocks;
  final Size absoluteImageSize;

  ScanTextPainter({
    required this.blocks,
    required this.absoluteImageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(Rect boundingBox) {
      return Rect.fromLTRB(
        boundingBox.left * scaleX,
        boundingBox.top * scaleY,
        boundingBox.right * scaleX,
        boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (TextBlock block in blocks) {
      paint.color = Colors.red;
      canvas.drawRect(scaleRect(block.boundingBox), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
