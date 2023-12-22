// ignore_for_file: constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/views/remove.dart';
import 'package:skyradio_mobile/widgets/dialog.dart';

class SkDialog extends InheritedWidget {
  late BuildContext _context;

  SkDialog({
    super.key,
    required super.child,
  });

  Future<T?> pushNamed<T>(String name, {Object? arguments}) async {
    final settings = RouteSettings(
      name: name,
      arguments: arguments,
    );

    return skDialog<T>(
      _context,
      DialogGenerator.generate(settings),
    );
  }

  static SkDialog of(BuildContext context) {
    final instance = context.dependOnInheritedWidgetOfExactType<SkDialog>()!;

    instance._context = context;

    return instance;
  }

  @override
  bool updateShouldNotify(SkDialog oldWidget) => false;
}

const REMOVE_DIALOG = '/remove_dialog';

class DialogGenerator {
  static Widget generate(RouteSettings settings) {
    switch (settings.name) {
      case REMOVE_DIALOG:
        return RemoveDialogView(
          instance: settings.arguments as String,
        );
      default:
        return Container();
    }
  }
}
