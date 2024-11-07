import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tu_barrio/components/appbar.dart'; // Acuérdate que modular estilos es el nombre MI PROYECTO
import 'package:tu_barrio/components/formulario.dart';

class Mantenedor extends StatefulWidget {
  const Mantenedor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MantenedorState createState() => _MantenedorState();
}

class _MantenedorState extends State<Mantenedor> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BlogScreen(),
    const CallsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Profesores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Búsqueda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context), // Usando la función de appbar.dart
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay registros disponibles.'));
          }

          final usuarios = snapshot.data!.docs;

          return ListView.separated(
            itemCount: usuarios.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color.fromARGB(255, 235, 235, 235), // Color del divisor
              thickness: 1, // Grosor del divisor
            ),
            itemBuilder: (context, index) {
              final usuario = usuarios[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(
                  '${usuario['nombre']}',
                  style: const TextStyle(fontWeight: FontWeight.bold), // Título en negrita
                ),
                subtitle: Text('${usuario['telefono']}'), // Muestra el teléfono
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.9, // Ajusta la altura si deseas menos del 100%
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FormularioScreen(),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el modal
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda'),
      ),
      body: const Center(
        child: Text('Pantalla de búsqueda'),
      ),
    );
  }
}

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: const Center(
        child: Text('Pantalla de blog'),
      ),
    );
  }
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensaje'),
      ),
      body: const Center(
        child: Text('Pantalla de mensajes'),
      ),
    );
  }
}
