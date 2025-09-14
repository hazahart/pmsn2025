import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../utils/value_listener.dart';

class HomeScreen extends StatefulWidget {
  // 1. El campo de usuario ahora es opcional (nullable).
  final Map<String, dynamic>? user;

  // 2. El constructor ya no requiere el parámetro 'user'.
  const HomeScreen({super.key, this.user});

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
        toastification.show(
          context: context,
          title: const Text('Buscar'),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(milliseconds: 3000),
          alignment: Alignment.topRight,
        );
        break;
      case 3:
        toastification.show(
          context: context,
          title: const Text('Notificaciones'),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(milliseconds: 3000),
          alignment: Alignment.topRight,
        );
        break;
      case 4:
        toastification.show(
          context: context,
          title: const Text('Contactos'),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(milliseconds: 3000),
          alignment: Alignment.topRight,
        );
        break;
    }
  }

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

    // 3. Se extrae la ruta de la imagen de forma segura (puede ser nula).
    final imagePath = widget.user?['imagePath'] as String?;

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
        // 4. Se actualiza el Drawer para manejar el caso en que 'user' sea nulo.
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundImage: imagePath != null ? FileImage(File(imagePath)) : null,
                child: imagePath == null
                    ? const Icon(Icons.person, size: 40, color: Colors.white)
                    : null,
              ),
              accountName: Text(
                // Se usan valores por defecto si el usuario es nulo.
                widget.user?['fullName'] ?? "Nombre de Usuario",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: Text(widget.user?['email'] ?? "correo@ejemplo.com"),
            ),
            ListTile(
              leading: const Icon(Icons.sports_esports),
              title: const Text("Practica 1"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/practica_1');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar Sesión"),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
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
          child: ValueListenableBuilder(
            valueListenable: ValueListener.isDark,
            builder: (context, value, child) {
              return Icon(value ? Icons.light_mode : Icons.dark_mode);
            },
          )
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

