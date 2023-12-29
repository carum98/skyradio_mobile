import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();

    availableCameras().then((value) {
      controller = CameraController(
        value.first,
        ResolutionPreset.high,
      );

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }

        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller?.value.isInitialized != true) {
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
          child: CameraPreview(controller!),
        ),
      ),
    );
  }
}
