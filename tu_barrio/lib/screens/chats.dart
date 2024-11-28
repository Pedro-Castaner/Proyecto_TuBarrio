import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _currentIndex = 0;

  // Lista de pantallas que corresponderán a cada ítem en la barra de navegación
  final List<Widget> _screens = [
    const ExploreScreen(), // Pantalla de explorar
    const FavoritesScreen(), // Pantalla de favoritos
    const CommunitiesScreen(), // Pantalla de comunidades
    const MessagesScreen(), // Pantalla de mensajes
    const ProfileScreen(), // Pantalla de perfil
  ];

  // Función para cambiar la pantalla según la opción seleccionada en la barra de navegación
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Mi App',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: _screens[_currentIndex], // Mostrar la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice actual de la barra de navegación
        onTap: _onItemTapped, // Función al hacer tap en un ítem
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Ícono de lupa para "Explorar"
            label: 'Explorar',
            backgroundColor: Colors.lightBlue, // Color de fondo para este ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.favorite_border), // Ícono de corazón para "Favoritos"
            label: 'Favoritos',
            backgroundColor: Colors.blue, // Color de fondo para este ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .people_outline), // Ícono de silueta de personas para "Comunidades"
            label: 'Comunidades',
            backgroundColor: Colors.lightBlue, // Color de fondo para este ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message), // Ícono de mensaje para "Mensajes"
            label: 'Mensajes',
            backgroundColor: Colors.blue, // Color de fondo para este ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), // Ícono de perfil para "Perfil"
            label: 'Perfil',
            backgroundColor: Colors.lightBlue, // Color de fondo para este ítem
          ),
        ],
        selectedItemColor:
            Colors.white, // Color del ícono cuando está seleccionado
        unselectedItemColor:
            Colors.black, // Color del ícono cuando NO está seleccionado
        showSelectedLabels:
            true, // Mostrar las etiquetas de los íconos seleccionados
        showUnselectedLabels:
            true, // Mostrar las etiquetas de los íconos no seleccionados
      ),
    );
  }
}

// Pantalla de Explorar
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Explorar'));
  }
}

// Pantalla de Favoritos
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Favoritos'));
  }
}

// Pantalla de Comunidades
class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Comunidades'));
  }
}

// Pantalla de Mensajes
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mensajes'));
  }
}

// Pantalla de Perfil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Perfil'));
  }
}
