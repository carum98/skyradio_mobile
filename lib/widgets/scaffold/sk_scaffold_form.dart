import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/button.dart';

abstract class SkScaffoldFormModel with ChangeNotifier {
  late final RequestData _data;

  final String? code;
  SkScaffoldFormModel({this.code}) {
    _data = getParams();
  }

  bool get isEditing => code != null;
  bool get isValid;

  RequestData getParams();
  bool isDirty() {
    if (isEditing) {
      return mapEquals(_data, getParams());
    } else {
      return true;
    }
  }
}

class SkScaffoldForm<T extends SkScaffoldFormModel> extends StatelessWidget {
  final T model;
  final List<Widget> Function(T) builder;
  final Function(RequestParams) onSend;

  const SkScaffoldForm({
    super.key,
    required this.model,
    required this.builder,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Wrap(
          runSpacing: 20,
          children: builder(model),
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: model,
        builder: (_, child) => AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: model.isValid && !model.isDirty()
              ? Offset.zero
              : const Offset(0, 3),
          child: child,
        ),
        child: SkButton(
          onPressed: () {
            onSend(model.getParams());
          },
          text: 'Guardar',
        ),
      ),
    );
  }
}
