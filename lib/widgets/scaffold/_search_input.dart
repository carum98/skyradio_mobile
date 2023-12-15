part of 'sk_scaffold.dart';

class _SearchInput extends StatefulWidget {
  final void Function(String) onChanged;

  const _SearchInput({
    required this.onChanged,
  });

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  late final LayerLink layerLink;
  late final FocusNode focusNode;
  late final OverlayPortalController overlayPortalController;

  @override
  void initState() {
    super.initState();

    layerLink = LayerLink();
    focusNode = FocusNode();
    overlayPortalController = OverlayPortalController();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        overlayPortalController.show();
      } else {
        overlayPortalController.hide();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: OverlayPortal(
        controller: overlayPortalController,
        child: TextField(
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Buscar',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
          ),
          onChanged: widget.onChanged,
        ),
        overlayChildBuilder: (_) {
          return CompositedTransformFollower(
            link: layerLink,
            targetAnchor: Alignment.bottomLeft,
            offset: const Offset(0, 10),
            child: Stack(
              children: [
                ModalBarrier(
                  onDismiss: () {
                    focusNode.unfocus();
                    overlayPortalController.hide();
                  },
                ),
                const Positioned(
                  child: _SearchInputActions(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchInputActions extends StatelessWidget {
  const _SearchInputActions();

  @override
  Widget build(BuildContext context) {
    Widget buildButton({
      required void Function() onPressed,
      required String label,
      required IconData icon,
    }) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).textTheme.bodySmall!.color,
        ),
        icon: Icon(icon, size: 18),
        label: Text(label),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildButton(
            onPressed: () {},
            label: 'Escanear codigos QR/Barra',
            icon: Icons.qr_code_scanner,
          ),
          buildButton(
            onPressed: () {},
            label: 'Extraer texto de imagenes',
            icon: Icons.image,
          ),
          buildButton(
            onPressed: () {},
            label: 'Dictar por voz',
            icon: Icons.mic,
          ),
        ],
      ),
    );
  }
}
