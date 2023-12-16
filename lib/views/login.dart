import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/widgets/button.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkInput.label(
                label: 'Correo',
                placeholder: 'Correo',
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 10),
              SkInput.label(
                label: 'Contraseña',
                placeholder: 'Contraseña',
                onChanged: (value) => password = value,
              ),
              const SizedBox(height: 30),
              SkButton.block(
                onPressed: login,
                text: 'Iniciar sesión',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
