import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = DI.of(context).authRepository;

    String email = '';
    String password = '';

    void login() async {
      await repo.login(email, password);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HOME_VIEW,
          (route) => false,
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo',
                ),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                onChanged: (value) => password = value,
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
