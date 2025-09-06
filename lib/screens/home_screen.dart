import 'package:flutter/material.dart';

import '../utils/value_listener.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedItem = "";

  void _onItemTapped(int index, String? nombre) {
    setState(() {
      _selectedItem = nombre ?? "";
      _selectedIndex = index;
    });
  }

  Widget _buildIcon(IconData icon, int index, String nombre) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index, nombre),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedScale(
          scale: isSelected ? 1.3 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey[600],
            size: 28,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ci'),
        actions: [
          ValueListenableBuilder(
            valueListenable: ValueListener.isDark,
            builder: (context, value, child) {
              return value
                  ? IconButton(
                      onPressed: () {
                        ValueListener.isDark.value = false;
                      },
                      icon: Icon(Icons.light_mode),
                    )
                  : IconButton(
                      onPressed: () {
                        ValueListener.isDark.value = true;
                      },
                      icon: Icon(Icons.dark_mode),
                    );
            },
          ),
        ],
      ),
      body: Center(child: Text('Seleccionaste $_selectedItem')),
      drawer: Drawer(
        child: NavigationDrawer(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundImage: ValueListener.isDark.value
                    ? NetworkImage("https://media1.tenor.com/m/ulUwa3QqhooAAAAC/kazuha-genshin-impact-kazuha-drinking.gif")
                    : null,
                child: !ValueListener.isDark.value
                    ? Icon(Icons.person, size: 30, color: Colors.white)
                    : null,
              ),
              accountName: Text(
                "Username",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                "usermail@email.com",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ValueListener.isDark.value = !ValueListener.isDark.value;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        ),
        child: ValueListener.isDark.value
            ? Icon(Icons.light_mode)
            : Icon(Icons.dark_mode),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.amber,
        elevation: 5,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(Icons.home, 0, "Home"),
            _buildIcon(Icons.search, 1, "Buscar"),
            const SizedBox(width: 48),
            _buildIcon(Icons.notifications, 2, "Notificaciones"),
            _buildIcon(Icons.person, 3, "Contactos"),
          ],
        ),
      ),
    );
  }
}
