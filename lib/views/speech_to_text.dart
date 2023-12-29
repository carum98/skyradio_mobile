import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextView extends StatefulWidget {
  const SpeechToTextView({super.key});

  @override
  State<SpeechToTextView> createState() => _SpeechToTextViewState();
}

class _SpeechToTextViewState extends State<SpeechToTextView> {
  late final SpeechToText speech;

  bool isListening = false;
  String text = '';

  @override
  void initState() {
    super.initState();

    speech = SpeechToText();
  }

  @override
  void dispose() {
    super.dispose();

    speech.cancel();
  }

  Future<void> startListening() async {
    if (await speech.initialize()) {
      setState(() => isListening = true);

      speech.listen(
        onResult: (value) {
          setState(() => text = value.recognizedWords);
        },
        localeId: 'es_ES',
      );
    }
  }

  Future<void> stopListening() async {
    setState(() => isListening = false);

    speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          constraints: const BoxConstraints(minHeight: 100),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(text),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Button(
              color: Colors.red.withOpacity(0.6),
              icon: Icons.close,
              dense: true,
              disabled: text.isEmpty,
              onTap: () {
                setState(() {
                  text = '';
                });
              },
            ),
            const SizedBox(width: 20),
            _Button(
              color: Theme.of(context).primaryColor,
              icon: Icons.mic,
              onTapDown: (_) => startListening(),
              onTapUp: (_) => stopListening(),
            ),
            const SizedBox(width: 20),
            _Button(
              color: Colors.green.withOpacity(0.6),
              icon: Icons.check,
              dense: true,
              disabled: text.isEmpty,
              onTap: () {
                Navigator.of(context).pop(text);
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final IconData icon;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final bool disabled;
  final bool dense;

  const _Button({
    required this.color,
    required this.icon,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.disabled = false,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final padding = dense ? 10.0 : 15.0;
    final iconSize = dense ? 20.0 : 30.0;

    return InkWell(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      child: Ink(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey.withOpacity(0.3) : color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: iconSize),
      ),
    );
  }
}
