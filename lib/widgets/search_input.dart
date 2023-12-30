import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/bottom_sheet.dart';

class SkSearchInput extends StatefulWidget {
  final void Function(String) onChanged;

  const SkSearchInput({
    super.key,
    required this.onChanged,
  });

  @override
  State<SkSearchInput> createState() => _SkSearchInputState();
}

class _SkSearchInputState extends State<SkSearchInput> {
  late final LayerLink layerLink;
  late final FocusNode focusNode;
  late final OverlayPortalController overlayPortalController;
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    layerLink = LayerLink();
    focusNode = FocusNode();
    overlayPortalController = OverlayPortalController();
    textEditingController = TextEditingController();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        overlayPortalController.show();
      } else {
        overlayPortalController.hide();
      }
    });

    textEditingController.addListener(() {
      if (textEditingController.text.length == 1) {
        overlayPortalController.hide();
      } else if (textEditingController.text.isEmpty) {
        overlayPortalController.show();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: OverlayPortal(
        controller: overlayPortalController,
        child: TextField(
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: 'Buscar',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(Icons.search),
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
                Positioned(
                  child: _SearchInputActions(
                    onChanged: (value) {
                      textEditingController.text = value;
                      widget.onChanged(value);
                    },
                  ),
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
  final void Function(String) onChanged;

  const _SearchInputActions({required this.onChanged});

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
            label: 'Escanear codigos QR/Barra',
            icon: Icons.qr_code_scanner,
            onPressed: () async {
              final value = await SkBottomSheet.of(context).pushNamed<String?>(
                SCAN_CODE,
                padding: EdgeInsets.zero,
              );

              if (value != null) {
                onChanged(value);
              }
            },
          ),
          buildButton(
            label: 'Extraer texto de imagenes',
            icon: Icons.image,
            onPressed: () async {
              final value = await SkBottomSheet.of(context).pushNamed<String?>(
                SCAN_TEXT,
                padding: EdgeInsets.zero,
              );

              if (value != null) {
                onChanged(value);
              }
            },
          ),
          buildButton(
            label: 'Dictar por voz',
            icon: Icons.mic,
            onPressed: () async {
              final value = await SkBottomSheet.of(context).pushNamed<String?>(
                SPEECH_TO_TEXT,
              );

              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
