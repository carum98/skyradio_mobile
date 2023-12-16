import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          const SwitchTheme(),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(45, 45),
            ),
            child: const Icon(
              Icons.arrow_drop_down_rounded,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CLIENTS_VIEW);
              },
              child: const Text('Clientes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RADIOS_VIEW);
              },
              child: const Text('Radios'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SIMS_VIEW);
              },
              child: const Text('Sims'),
            ),
          ],
        ),
      ),
    );
  }
}

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
