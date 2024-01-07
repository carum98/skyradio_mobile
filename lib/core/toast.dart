// ignore_for_file: constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/widgets/toast.dart';

class SkToast extends InheritedWidget {
  late BuildContext _context;

  SkToast({
    super.key,
    required super.child,
  });

  void success(String message) {
    skToast(
      _context,
      title: 'Success',
      message: message,
      type: SkToastType.success,
    );
  }

  void error(String message) {
    skToast(
      _context,
      title: 'Error',
      message: message,
      type: SkToastType.error,
    );
  }

  void info(String message) {
    skToast(
      _context,
      title: 'Info',
      message: message,
      type: SkToastType.info,
    );
  }

  void warning(String message) {
    skToast(
      _context,
      title: 'Warning',
      message: message,
      type: SkToastType.warning,
    );
  }

  static SkToast of(BuildContext context) {
    final instance = context.dependOnInheritedWidgetOfExactType<SkToast>()!;

    instance._context = context;

    return instance;
  }

  @override
  bool updateShouldNotify(SkToast oldWidget) => false;
}
