import 'package:flutter/material.dart';
import 'package:pmsn2020/screens/home_screen.dart';
import 'package:pmsn2020/screens/login_screen.dart';
import 'package:pmsn2020/utils/theme_app.dart';
import 'package:pmsn2020/utils/value_listener.dart';

void main() => runApp(PMSNApp());

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueListener.isDark,
      builder: (context, value, _) {
        return MaterialApp(
          theme: value ? ThemeData.dark() : ThemeData.light(),
          // darkTheme: ThemeApp.darkTheme(),
          // themeMode: ThemeMode.system,
          title: 'Material App',
          home: LoginScreen(),
          routes: {
            '/home': (context) => HomeScreen(),
          },
        );
      }
    );
  }
}
