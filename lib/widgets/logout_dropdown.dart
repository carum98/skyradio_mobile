import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';

import 'icons.dart';

class LogoutDropdown extends StatelessWidget {
  const LogoutDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      splashRadius: 0,
      offset: const Offset(0, 40),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(45, 45),
        ),
        child: const Icon(
          Icons.arrow_drop_down_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SkIcon(SkIconData.logout, size: 20),
              SizedBox(width: 10),
              Text('Cerrar sesión', style: TextStyle(fontSize: 16))
            ],
          ),
        ),
      ],
      onSelected: (_) {
        final repository = DI.of(context).authRepository;

        repository.logout();

        Navigator.of(context).pushNamedAndRemoveUntil(
          LOGIN_VIEW,
          (route) => false,
        );
      },
    );
  }
}
