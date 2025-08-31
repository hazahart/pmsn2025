import 'package:flutter/material.dart';
import 'package:pmsn2020/screens/login_screen.dart';

void main() => runApp(PMSNApp());

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Material App',
      home: LoginScreen(),
    );
  }
}
