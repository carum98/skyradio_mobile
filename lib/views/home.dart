import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/widgets/icons.dart';

import 'clients/list.dart';
import 'radios/list.dart';
import 'sims/list.dart';

final _views = [
  (
    text: 'Clientes',
    icon: SkIconData.clients,
    child: const ClientsView(),
  ),
  (
    text: 'Radios',
    icon: SkIconData.radios,
    child: const RadiosView(),
  ),
  (
    text: 'SIMs',
    icon: SkIconData.sims,
    child: const SimsView(),
  ),
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _Home2ViewState();
}

class _Home2ViewState extends State<HomeView> {
  late final ValueNotifier<int> _index;

  @override
  void initState() {
    super.initState();

    _index = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    super.dispose();

    _index.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _views[_index.value].child,
      bottomNavigationBar: SafeArea(
        child: _NavigationBar(
          items: _views
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  _Button(
                    onPressed: () {
                      setState(() => _index.value = index);
                    },
                    icon: value.icon,
                    text: value.text,
                    isActive: _index.value == index,
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final List<_Button> items;

  const _NavigationBar({required this.items});

  @override
  Widget build(BuildContext context) {
    final state = DI.of(context).state;

    return ListenableBuilder(
      listenable: state,
      builder: (_, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: state.showBottomBar ? kBottomNavigationBarHeight + 20 : 0,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: child!,
        );
      },
      child: Center(
        child: Wrap(
          clipBehavior: Clip.hardEdge,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items,
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final SkIconData icon;
  final String text;
  final Function() onPressed;
  final bool isActive;

  const _Button({
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Opacity(
          opacity: isActive ? 0.7 : 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFd2dff9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SkIcon(
                  icon,
                  color: const Color(0xFF2a5a8a),
                  size: 29,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
