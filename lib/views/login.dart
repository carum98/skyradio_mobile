import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/widgets/input.dart';

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

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          child: Wrap(
            runSpacing: 10,
            children: [
              SkInput.label(
                label: 'Correo',
                placeholder: 'Correo',
                onChanged: (value) => email = value,
              ),
              SkInput.label(
                label: 'Contraseña',
                placeholder: 'Contraseña',
                onChanged: (value) => password = value,
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
