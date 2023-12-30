import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';

import 'icons.dart';

class SwitchTheme extends StatefulWidget {
  const SwitchTheme({super.key});

  @override
  State<SwitchTheme> createState() => _SwitchThemeState();
}

class _SwitchThemeState extends State<SwitchTheme> {
  @override
  Widget build(BuildContext context) {
    final state = DI.of(context).state;

    return GestureDetector(
      onTap: () {
        setState(() {
          state.setThemeMode(
            state.themeMode == ThemeMode.dark
                ? ThemeMode.light
                : ThemeMode.dark,
          );
        });
      },
      child: SkIcon(
        state.themeMode == ThemeMode.dark ? SkIconData.moon : SkIconData.sun,
        color: state.themeMode == ThemeMode.dark ? null : Colors.orange,
        size: 30,
      ),
    );
  }
}
