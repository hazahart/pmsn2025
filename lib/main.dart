import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2020/firebase_options.dart';
import 'package:pmsn2020/practica_1/p1_main.dart';
import 'package:pmsn2020/screens/add_movie_screen.dart';
import 'package:pmsn2020/screens/home_screen.dart';
import 'package:pmsn2020/screens/list_movies.dart';
import 'package:pmsn2020/screens/list_songs_screen.dart';
import 'package:pmsn2020/screens/login_screen.dart';
import 'package:pmsn2020/screens/register_screen.dart';
import 'package:pmsn2020/utils/theme_app.dart';
import 'package:pmsn2020/utils/value_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PMSNApp());
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueListener.isDark,
      builder: (context, value, _) {
        return MaterialApp(
          theme: value ? ThemeApp.darkTheme() : ThemeApp.lightTheme(),
          title: 'Material App',
          // Se define la ruta inicial de la aplicación.
          initialRoute: '/home',
          routes: {
            // Se define la ruta de login explícitamente.
            '/login': (context) => const LoginScreen(),
            '/listdb': (context) => ListMovies(),
            '/addmovie': (context) => AddMovieScreen(),
            '/register': (context) => const RegisterScreen(),
            '/practica_1': (context) => ResonatorScreen(),
            '/songslist': (context) => const ListSongsScreen(),
            // Ahora la ruta '/home' sabe cómo recibir y procesar los datos del usuario.
            '/home': (context) {
              // 1. Se extraen los argumentos (el mapa del usuario) de la ruta de forma segura.
              final user =
                  ModalRoute.of(context)?.settings.arguments
                      as Map<String, dynamic>?;
              // 2. Se pasan los datos del usuario (o null) al constructor de HomeScreen.
              return HomeScreen(user: user);
            },
          },
        );
      },
    );
  }
}
