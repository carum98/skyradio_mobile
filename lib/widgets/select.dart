import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/utils/api_params.dart';

import 'bottom_sheet.dart';
import 'label.dart';
import 'listview_pagination/sk_listview_pagination.dart';

class SkSelect<T> extends StatefulWidget {
  final ApiProvider<T> provider;
  final RequestParams? filters;
  final String placeholder;
  final T? initialValue;
  final Function(T?) onChanged;
  final Widget Function(T item) itemBuilder;
  final bool? showClearButton;
  final bool isRequired;

  const SkSelect({
    super.key,
    required this.provider,
    required this.placeholder,
    required this.onChanged,
    required this.itemBuilder,
    this.initialValue,
    this.filters,
    this.showClearButton,
    this.isRequired = false,
  });

  static Widget label<T>({
    required String label,
    required ApiProvider<T> provider,
    required String placeholder,
    required Function(T?) onChanged,
    required Widget Function(T item) itemBuilder,
    T? initialValue,
    bool? showClearButton,
    bool? isRequired,
  }) {
    return SkLabel(
      label: label,
      isRequired: isRequired,
      child: SkSelect(
        provider: provider,
        placeholder: placeholder,
        initialValue: initialValue,
        onChanged: onChanged,
        itemBuilder: itemBuilder,
        showClearButton: showClearButton,
        isRequired: isRequired ?? false,
      ),
    );
  }

  @override
  State<SkSelect<T>> createState() => _SkSelectState<T>();
}

class _SkSelectState<T> extends State<SkSelect<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();

    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final controller = SkListViewPaginationController<T>(
      provider: widget.provider,
      params: ApiParams(
        filter: widget.filters != null ? _SelectFilters(widget.filters!) : null,
      ),
    );

    return Stack(
      children: [
        TextFormField(
          readOnly: true,
          validator: (_) {
            if (widget.isRequired && _value == null) {
              return 'Este campo es requerido';
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: _value == null ? widget.placeholder : '',
            suffixIcon: (widget.showClearButton == true && _value != null)
                ? IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        widget.onChanged(null);
                        _value = null;
                      });
                    },
                  )
                : null,
          ),
          onTap: () {
            skBottomSheet(
              context,
              Column(
                children: [
                  TextField(
                    onChanged: controller.search,
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
                      controller: controller,
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

class _SelectFilters extends ApiFilterModel {
  final RequestParams filters;
  _SelectFilters(this.filters);

  @override
  RequestParams toRequestParams() => filters;
}
