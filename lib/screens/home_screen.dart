import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ci')),
      body: Center(child: Text('Menu de opciones')),
      drawer: Drawer(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: "Home",
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              tooltip: "Search",
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.dark_mode),
            ),
            IconButton(
              tooltip: "Notifications",
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              tooltip: "Profile",
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
