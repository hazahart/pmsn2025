import 'package:flutter/material.dart';

import '../utils/value_listener.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, String? nombre) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/practica_1');
        break;
      case 1:
        print("Abrir búsqueda");
        break;
      case 2:
        print("Notificaciones");
        break;
      case 3:
        print("Abrir contactos");
        break;
    }
  }

  // Grid de botones
  Widget _buildGridButton(IconData icon, String label, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () => _onItemTapped(index, label),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Construccion de los borones de la barra de navegación
  Widget _buildIcon(
    IconData outlinedIcon,
    IconData filledIcon,
    int index,
    String nombre,
  ) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index, nombre),
      child: Tooltip(
        message: nombre,
        // el tooltip es para el texto que se muestra al mantener presionado el boton
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
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected ? Colors.blue : Colors.grey[600],
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  // metodo principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PMSN 2025-2'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          // declaracion del grid de botones
          children: [
            _buildGridButton(Icons.sports_esports, "Practica 1", 0),
            _buildGridButton(Icons.search, "Buscar", 1),
            _buildGridButton(Icons.notifications, "Notificaciones", 2),
            _buildGridButton(Icons.person, "Contactos", 3),
          ],
        ),
      ),
      drawer: Drawer(
        child: NavigationDrawer(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundImage: ValueListener.isDark.value
                    ? NetworkImage(
                        "https://media1.tenor.com/m/ulUwa3QqhooAAAAC/kazuha-genshin-impact-kazuha-drinking.gif",
                      )
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
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Practcia 1"),
              onTap: () => Navigator.pushNamed(context, '/practica_1'),
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
          // botones de la barra de navegación
          children: [
            _buildIcon(
              Icons.sports_esports_outlined,
              Icons.sports_esports,
              0,
              "Practica 1",
            ),
            _buildIcon(Icons.search_outlined, Icons.search, 1, "Buscar"),
            const SizedBox(width: 48),
            _buildIcon(
              Icons.notifications_outlined,
              Icons.notifications,
              2,
              "Notificaciones",
            ),
            _buildIcon(Icons.person_outline, Icons.person, 3, "Contactos"),
          ],
        ),
      ),
    );
  }
}
