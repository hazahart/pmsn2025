import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pmsn2020/database/users_database.dart';
import 'package:pmsn2020/firebase/firebase_auth.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final UsersDatabase usersDB = UsersDatabase();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  FirebaseAuthentication? firebaseAuthentication;

  @override
  initState() {
    super.initState();
    firebaseAuthentication = FirebaseAuthentication();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = p.basename(pickedFile.path);
      final savedImage = await File(
        pickedFile.path,
      ).copy('${appDir.path}/$fileName');

      setState(() {
        _profileImage = savedImage;
      });
    } catch (e) {
      showToast(
        'Error al seleccionar o guardar la imagen',
        tipo: ToastificationType.error,
      );
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galería'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Cámara'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final opacityDark = isDark ? 0.5 : 1.0;

    final txtName = TextField(
      controller: nameController,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Nombre completo',
        hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.3) : Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final txtUser = TextField(
      controller: userController,
      keyboardType: TextInputType.emailAddress,
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
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Contraseña',
        hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.3) : Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final txtConfirmPassword = TextField(
      controller: confirmPasswordController,
      obscureText: true,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: 'Confirmar contraseña',
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
                    'Crear Cuenta',
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
                            GestureDetector(
                              onTap: () => _showImageSourceActionSheet(context),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: isDark
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.grey[400],
                                backgroundImage: _profileImage != null
                                    ? FileImage(_profileImage!)
                                    : null,
                                child: _profileImage == null
                                    ? Icon(
                                        Icons.add_a_photo,
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.white,
                                        size: 40,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 20),
                            txtName,
                            const SizedBox(height: 10),
                            txtUser,
                            const SizedBox(height: 10),
                            txtPassword,
                            const SizedBox(height: 10),
                            txtConfirmPassword,
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => register(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? Colors.green[200]
                                    : Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                              ),
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                '¿Ya tienes una cuenta? Inicia sesión',
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

  void register() async {
    final name = nameController.text;
    final email = userController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (_profileImage == null) {
      showToast(
        "Por favor, selecciona una imagen de perfil.",
        tipo: ToastificationType.warning,
      );
      return;
    }

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showToast(
        "Por favor, completa todos los campos.",
        tipo: ToastificationType.warning,
      );
      return;
    }

    if (password != confirmPassword) {
      showToast(
        "Las contraseñas no coinciden.",
        tipo: ToastificationType.error,
      );
      return;
    }

    final existingUser = await usersDB.getUserByEmail(email);
    if (existingUser != null) {
      showToast(
        "Este correo electrónico ya está registrado.",
        tipo: ToastificationType.error,
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      showToast(
        "Por favor, introduce un correo electrónico válido.",
        tipo: ToastificationType.error,
      );
      return;
    }

    Map<String, dynamic> userData = {
      'fullName': name,
      'email': email,
      'password': password,
      'imagePath': _profileImage!.path,
    };

    final newUserId = await usersDB.insertUser(userData);

    if (newUserId > 0) {
      // Obtenemos los datos del usuario recién insertado para pasarlos a la siguiente pantalla
      final newUser = await usersDB.getUserByEmail(email);
      showToast("¡Registro exitoso, $name!", tipo: ToastificationType.success);
      setState(() {
        isLoading = true;
      });

      // Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      //   // Ahora se envían los datos del nuevo usuario como argumento.
      //   Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: newUser);
      // });
      firebaseAuthentication!
          .registerWithEmailAndPassword(email, password)
          .then((user) {
            if (user != null) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
                arguments: newUser,
              );
            } else {
              showToast(
                "Ocurrió un error durante el registro.",
                tipo: ToastificationType.error,
              );
            }
          });
    } else {
      showToast(
        "Ocurrió un error durante el registro.",
        tipo: ToastificationType.error,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    userController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
