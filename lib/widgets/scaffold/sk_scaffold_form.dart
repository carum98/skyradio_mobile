import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/button.dart';

abstract class SkFormModel with ChangeNotifier {
  late final RequestData _data;

  final String? code;
  SkFormModel({this.code}) {
    _data = getParams();
  }

  bool get isEditing => code != null;
  bool get isValid;

  RequestData getParams();
  bool isDirty() {
    if (isEditing) {
      return mapEquals(_data, getParams());
    } else {
      return false;
    }
  }
}

class SkScaffoldForm<T extends SkFormModel> extends StatelessWidget {
  final T model;
  final List<Widget> Function(T) builder;
  final Future<void> Function(RequestParams) onSend;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SkScaffoldForm({
    super.key,
    required this.model,
    required this.builder,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Form(
          key: formKey,
          child: Wrap(
            runSpacing: 20,
            children: builder(model),
          ),
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
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;

            await onSend(model.getParams());

            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(true);
          },
          text: 'Guardar',
        ),
      ),
    );
  }
}
