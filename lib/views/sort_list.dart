import 'package:flutter/material.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

typedef ItemValue = ({String name, String value});

const List<ItemValue> _fields = [
  (name: 'Nombre', value: 'name'),
  (name: 'Fecha de creación', value: 'created_at'),
  (name: 'Fecha de actualización', value: 'updated_at'),
];

const List<ItemValue> _order = [
  (name: 'Ascendente', value: 'asc'),
  (name: 'Descendente', value: 'desc'),
];

class SortListView extends StatefulWidget {
  final ApiSortModel sort;
  final VoidCallback onRefresh;

  const SortListView({
    super.key,
    required this.onRefresh,
    required this.sort,
  });

  @override
  State<SortListView> createState() => _SortListViewState();
}

class _SortListViewState extends State<SortListView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              for (var item in _fields)
                _SortButton(
                  text: item.name,
                  onPressed: () {
                    widget.sort.field = item.value;
                    widget.onRefresh();
                    setState(() {});
                  },
                  selected: widget.sort.field == item.value,
                ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              for (var item in _order)
                _SortButton(
                  text: item.name,
                  icon: item.value == 'asc' ? SkIconData.asc : SkIconData.desc,
                  onPressed: () {
                    widget.sort.order = item.value;
                    widget.onRefresh();
                    setState(() {});
                  },
                  selected: widget.sort.order == item.value,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SortButton extends StatelessWidget {
  final String text;
  final SkIconData? icon;
  final VoidCallback onPressed;
  final bool selected;

  const _SortButton({
    required this.text,
    this.icon,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Theme.of(context).primaryColor : null,
          foregroundColor: selected
              ? Colors.white
              : Theme.of(context).textTheme.bodyMedium!.color,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              if (icon != null) ...[
                SkIcon(
                  icon!,
                  size: 16,
                  color: selected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium!.color,
                ),
                const SizedBox(width: 5),
              ],
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
