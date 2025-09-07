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
      case 1:
        Navigator.pushNamed(context, '/practica_1');
        break;
      case 2:
        print("Abrir búsqueda");
        break;
      case 3:
        print("Notificaciones");
        break;
      case 4:
        print("Abrir contactos");
        break;
    }
  }

  // Grid de botones con color dinámico y fondo opcional
  Widget _buildGridButton(
    IconData icon,
    String label,
    int index, {
    String? backgroundImage,
    double imageOpacity = 0.3,
    Color? backgroundColor,
    Color? dynamicColor,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: dynamicColor ?? backgroundColor ?? Colors.blueAccent,
      ),
      onPressed: () => _onItemTapped(index, label),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (backgroundImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Opacity(
                opacity: imageOpacity,
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Construccion de los botones de la barra de navegación
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withOpacity(0.2)
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PMSN 2025-2'),
        actions: [
          ValueListenableBuilder(
            valueListenable: ValueListener.isDark,
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  ValueListener.isDark.value = !ValueListener.isDark.value;
                },
                icon: Icon(value ? Icons.light_mode : Icons.dark_mode),
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
          children: [
            _buildGridButton(
              Icons.sports_esports,
              "Practica 1",
              1,
              backgroundImage: "assets/images/wuwa/wuwa_logo.jpg",
              imageOpacity: 0.4,
              backgroundColor: Colors.black87,
            ),
            _buildGridButton(
              Icons.search,
              "Buscar",
              2,
              dynamicColor: colorScheme.secondary,
            ),
            _buildGridButton(
              Icons.notifications,
              "Notificaciones",
              3,
              dynamicColor: colorScheme.tertiary,
            ),
            _buildGridButton(
              Icons.person,
              "Contactos",
              4,
              dynamicColor: colorScheme.surfaceContainerHighest,
            ),
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
              title: Text("Practica 1"),
              onTap: () => Navigator.pushNamed(context, '/practica_1'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ValueListener.isDark.value = !ValueListener.isDark.value;
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: ValueListener.isDark.value
            ? const Icon(Icons.light_mode)
            : const Icon(Icons.dark_mode),
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
            _buildIcon(
              Icons.sports_esports_outlined,
              Icons.sports_esports,
              1,
              "Practica 1",
            ),
            _buildIcon(Icons.search_outlined, Icons.search, 2, "Buscar"),
            const SizedBox(width: 48),
            _buildIcon(
              Icons.notifications_outlined,
              Icons.notifications,
              3,
              "Notificaciones",
            ),
            _buildIcon(Icons.person_outline, Icons.person, 4, "Contactos"),
          ],
        ),
      ),
    );
  }
}
