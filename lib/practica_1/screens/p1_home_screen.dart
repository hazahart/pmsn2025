import 'package:flutter/material.dart';

class P1HomeScreen extends StatefulWidget {
  const P1HomeScreen({super.key});

  @override
  State<P1HomeScreen> createState() => _P1HomeScreenState();
}

class _P1HomeScreenState extends State<P1HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hola Mundo"),
      ),
    );
  }
}
