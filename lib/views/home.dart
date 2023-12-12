import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final state = DI.of(context).state;

                state.setThemeMode(
                  state.themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                );
              },
              child: const Text('Toggle theme'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CLIENTS_VIEW);
              },
              child: const Text('Clientes'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Radios'),
            ),
          ],
        ),
      ),
    );
  }
}
