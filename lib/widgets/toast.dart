import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'icons.dart';

enum SkToastType {
  success,
  error,
  info,
  warning,
}

void skToast(
  BuildContext context, {
  required String title,
  required String message,
  required SkToastType type,
  Duration duration = const Duration(seconds: 3),
}) {
  _SkToast.show(
    context,
    title: title,
    message: message,
    type: type,
    duration: duration,
  );
}

class _SkToast {
  static final _SkToast _instance = _SkToast._internal();

  factory _SkToast() => _instance;

  _SkToast._internal();

  static final ValueNotifier<bool> _isShowing = ValueNotifier(false);
  static late OverlayState overlayState;
  static late OverlayEntry _overlayEntry;
  static bool _isVisible = false;
  static Timer? timer;

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required SkToastType type,
    Duration duration = const Duration(seconds: 5),
  }) {
    if (!_isVisible) {
      overlayState = Overlay.of(context);
    } else {
      hide();
    }

    _showOverlay(context, title, message, type, duration);
  }

  static void hide() {
    if (_isVisible) {
      _overlayEntry.remove();
      timer?.cancel();
      _isVisible = false;
      _isShowing.value = false;
    }
  }

  static void _showOverlay(
    BuildContext context,
    String title,
    String message,
    SkToastType type,
    Duration duration,
  ) async {
    _overlayEntry = OverlayEntry(
      builder: (context) => ValueListenableBuilder(
        valueListenable: _isShowing,
        builder: (_, value, child) => AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: value ? (kToolbarHeight + 15) : -kToolbarHeight,
          width: MediaQuery.of(context).size.width,
          child: child!,
        ),
        child: _SkToastWidget(
          title: title,
          message: message,
          type: type,
        ),
      ),
    );

    _isVisible = true;
    overlayState.insert(_overlayEntry);

    Future.delayed(const Duration(milliseconds: 100), () {
      _isShowing.value = true;
    });

    timer = Timer(duration, () {
      _isShowing.value = false;
      Future.delayed(const Duration(milliseconds: 300), hide);
    });
  }
}

class _SkToastWidget extends StatelessWidget {
  final String title;
  final String message;
  final SkToastType type;

  const _SkToastWidget({
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor(type);
    final icon = _getIcon(type);

    return Material(
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SkIcon(
                  icon,
                  color: color,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: color,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 110,
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                          color: color,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SkIconData _getIcon(SkToastType type) {
    switch (type) {
      case SkToastType.success:
        return SkIconData.success;
      case SkToastType.error:
        return SkIconData.error;
      case SkToastType.info:
        return SkIconData.info;
      case SkToastType.warning:
        return SkIconData.warning;
    }
  }

  Color _getColor(SkToastType type) {
    switch (type) {
      case SkToastType.success:
        return const Color.fromRGBO(134, 239, 172, 1);
      case SkToastType.error:
        return const Color.fromRGBO(248, 113, 113, 1);
      case SkToastType.info:
        return const Color.fromRGBO(96, 165, 250, 1);
      case SkToastType.warning:
        return const Color.fromRGBO(251, 146, 60, 1);
    }
  }
}
