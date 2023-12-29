import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    super.initState();
    startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
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

  void _stopLiveFeed() {
    _controller?.dispose();
    _textRecognizer.close();
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
      print(recognizedText.text);
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

    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: 1,
          child: CameraPreview(_controller!),
        ),
      ),
    );
  }
}
