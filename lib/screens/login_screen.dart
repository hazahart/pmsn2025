import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2020/database/users_database.dart';
import 'package:pmsn2020/firebase/firebase_auth.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final UsersDatabase usersDB = UsersDatabase();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FirebaseAuthentication? firebaseAuthentication;

  @override
  initState() {
    super.initState();
    firebaseAuthentication = FirebaseAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final opacityDark = isDark ? 0.5 : 1.0;

    final txtUser = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: userController,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Correo electrónico',
        hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.3) : Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final txtPassword = TextField(
      obscureText: true,
      controller: passwordController,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Contraseña',
        hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.3) : Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            txtUser,
                            const SizedBox(height: 10),
                            txtPassword,
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => loginWithFirebase(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? Colors.blue[200]
                                    : Colors.blue[300],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                              ),
                              child: const Text(
                                'Iniciar sesión',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/register'),
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
                  if (isLoading)
                    Lottie.asset('assets/animations/loader_cat.json')
                  else
                    Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showToast(
    String mensaje, {
    ToastificationType? tipo,
    AlignmentGeometry? align,
  }) {
    toastification.show(
      context: context,
      title: Text(mensaje),
      autoCloseDuration: const Duration(seconds: 4),
      type: tipo,
      alignment: align ?? Alignment.topCenter,
      style: ToastificationStyle.flat,
    );
  }

  void login() async {
    final email = userController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showToast(
        "Por favor, ingresa correo y contraseña.",
        tipo: ToastificationType.warning,
      );
      return;
    }

    final user = await usersDB.getUserByEmail(email);

    if (user == null) {
      showToast("Credenciales incorrectas.", tipo: ToastificationType.error);
      return;
    }

    final hashedPassword = UsersDatabase.hashPassword(password);

    if (hashedPassword == user['password']) {
      showToast(
        "¡Bienvenido, ${user['fullName']}!",
        tipo: ToastificationType.success,
      );
      setState(() {
        isLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 2000)).then((_) {
        // Ahora se envían los datos del usuario como argumento a la ruta '/home'.
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: user,
        );
      });
    } else {
      showToast("Credenciales incorrectas.", tipo: ToastificationType.error);
    }
  }

  void loginWithFirebase() async {
    final email = userController.text;
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      showToast(
        "Por favor, ingresa correo y contraseña.",
        tipo: ToastificationType.warning,
      );
      return;
    }
    firebaseAuthentication!.registerWithEmailAndPassword(email, password);
    final user = await usersDB.getUserByEmail(email);
    if (user == null) {
      showToast("Credenciales incorrectas.", tipo: ToastificationType.error);
      return;
    }
    final hashedPassword = UsersDatabase.hashPassword(password);
    if (hashedPassword == user['password']) {
      showToast(
        "¡Bienvenido, ${user['fullName']}!",
        tipo: ToastificationType.success,
      );
      setState(() {
        isLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 2000)).then((_) {
        // Ahora se envían los datos del usuario como argumento a la ruta '/home'.
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: user,
        );
      });
    } else {
      showToast("Credenciales incorrectas.", tipo: ToastificationType.error);
    }
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
