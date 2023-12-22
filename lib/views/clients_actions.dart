import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class ClientsActionsView extends StatelessWidget {
  final Clients client;
  final Function onRefresh;

  const ClientsActionsView({
    super.key,
    required this.client,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionButton(
          label: 'Historial',
          icon: SkIconData.history,
          onPressed: () {},
        ),
        const Divider(),
        _ActionButton(
          label: 'Cambio',
          icon: SkIconData.arrows,
          onPressed: () {},
        ),
        _ActionButton(
          label: 'Entrega',
          icon: SkIconData.arrow_down,
          onPressed: () {},
        ),
        _ActionButton(
          label: 'Devolución',
          icon: SkIconData.arrow_up,
          onPressed: () {},
        ),
        const Divider(),
        _ActionButton(
          label: 'Actualizar',
          icon: SkIconData.update,
          onPressed: () {
            Navigator.of(context)
                .pushNamed(CLIENT_UPDATE_VIEW, arguments: client)
                .then((value) => {if (value == true) onRefresh()});
          },
        ),
        _ActionButton(
          label: 'Eliminar',
          icon: SkIconData.trash,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final SkIconData icon;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkIcon(
              icon,
              size: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
