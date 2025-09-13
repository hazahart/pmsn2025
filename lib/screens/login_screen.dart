import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final opacityDark = isDark ? 0.5 : 1.0;

    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final txtUser = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: userController,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Correo electrónico',
        hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.grey[200],
        border: OutlineInputBorder(),
      ),
    );

    final txtPassword = TextField(
      keyboardType: TextInputType.visiblePassword,
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Contraseña',
        hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.grey[200],
        border: OutlineInputBorder(),
      ),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: opacityDark,
              child: Image.asset(
                "assets/images/login_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 25,
                      fontFamily: 'Vikings',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            txtUser,
                            const SizedBox(height: 10),
                            txtPassword,
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => login(userController.text),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? Colors.blue[200]
                                    : Colors.blue[300],
                              ),
                              child: Text(
                                'Iniciar sesión',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/register'),
                              child: Text(
                                'Registrarse',
                                style: TextStyle(color: Colors.blue[200]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  isLoading
                      ? Lottie.asset('assets/animations/loader_cat.json')
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showToast(
    String mensaje, {
    ToastificationType? tipo,
    AlignmentGeometry? align,
  }) {
    toastification.show(
      context: context,
      title: Text(mensaje),
      autoCloseDuration: Duration(seconds: 3),
      type: tipo,
      alignment: align,
    );
  }

  login(String user) {
    if (user.isEmpty) {
      showToast("Por favor ingresa tu correo", tipo: ToastificationType.error);
    } else {
      showToast(
        "Iniciando sesión como $user",
        tipo: ToastificationType.success,
      );
      isLoading = true;
      setState(() {});
      Future.delayed(
        Duration(milliseconds: 3000),
      ).then((value) => Navigator.pushNamed(context, '/home'));
    }
  }

  validar() {
    isLoading = true;
  }
}
