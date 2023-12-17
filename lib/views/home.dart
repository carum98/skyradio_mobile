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
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          _Button(
            onPressed: () {
              Navigator.of(context).pushNamed(CLIENTS_VIEW);
            },
            icon: SkIconData.clients,
            text: 'Clientes',
          ),
          _Button(
            onPressed: () {
              Navigator.of(context).pushNamed(RADIOS_VIEW);
            },
            icon: SkIconData.radios,
            text: 'Radios',
          ),
          _Button(
            onPressed: () {
              Navigator.of(context).pushNamed(SIMS_VIEW);
            },
            icon: SkIconData.sims,
            text: 'SIMs',
          ),
        ],
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

class _Button extends StatelessWidget {
  final SkIconData icon;
  final String text;
  final Function() onPressed;

  const _Button({
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFd2dff9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SkIcon(
                icon,
                color: const Color(0xFF2a5a8a),
                size: 35,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white)
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
