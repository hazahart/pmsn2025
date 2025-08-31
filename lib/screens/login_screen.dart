import 'dart:ui';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final txtUser = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: userController,
      decoration: InputDecoration(
        hintText: 'Correo electrónico',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    );

    final txtPassword = TextField(
      keyboardType: TextInputType.visiblePassword,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/images/login_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contenido
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Vikings',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Container con fondo borroso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            txtUser,
                            SizedBox(height: 10),
                            txtPassword,
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Iniciar sesión'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
