import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';

import 'bottom_sheet.dart';
import 'label.dart';
import 'listview_pagination/sk_listview_pagination.dart';

class SkSelect<T> extends StatefulWidget {
  final ApiProvider<T> provider;
  final String placeholder;
  final Function(T) onChanged;
  final Widget Function(T item) itemBuilder;

  const SkSelect({
    super.key,
    required this.provider,
    required this.placeholder,
    required this.onChanged,
    required this.itemBuilder,
  });

  static Widget label<T>({
    required String label,
    required ApiProvider<T> provider,
    required String placeholder,
    required Function(T) onChanged,
    required Widget Function(T item) itemBuilder,
  }) {
    return SkLabel(
      label: label,
      child: SkSelect(
        provider: provider,
        placeholder: placeholder,
        onChanged: onChanged,
        itemBuilder: itemBuilder,
      ),
    );
  }

  @override
  State<SkSelect<T>> createState() => _SkSelectState<T>();
}

class _SkSelectState<T> extends State<SkSelect<T>> {
  T? _value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: _value == null ? widget.placeholder : '',
          ),
          onTap: () {
            skBottomSheet(
              context,
              Column(
                children: [
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      enabledBorder: Theme.of(context)
                          .inputDecorationTheme
                          .enabledBorder!
                          .copyWith(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SkListViewPagination<T>(
                      provider: widget.provider,
                      builder: widget.itemBuilder,
                      padding: 0,
                      onTap: (item) {
                        widget.onChanged(item);
                        Navigator.pop(context);

                        setState(() {
                          _value = item;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (_value != null)
          Positioned(
            left: 10,
            top: 1,
            bottom: 1,
            child: IgnorePointer(
              ignoring: true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: widget.itemBuilder(_value as T),
              ),
            ),
          ),
      ],
    );
  }
}
