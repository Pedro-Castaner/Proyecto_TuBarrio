import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tu_barrio/components/formularioColection.dart';
import 'package:tu_barrio/components/formularioGrupos.dart';
import 'package:tu_barrio/screens/detalles_grupos.dart';

class Mantenedor extends StatefulWidget {
  const Mantenedor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MantenedorState createState() => _MantenedorState();
}

class _MantenedorState extends State<Mantenedor> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ExploreScreen(),
    const FavoritesScreen(),
    const CommunitiesScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Comunidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentIndex = 0; // Para rastrear la pestaña activa

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favoritos',
            style: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: 34,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 16),
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3.0,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'Productos'),
              Tab(text: 'Colecciones'),
            ],
            onTap: (index) {
              // Actualizamos el índice actual cuando se cambia la pestaña
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        body: const TabBarView(
          children: [
            // Contenido de Favoritos
            FavoritesTabContent(),
            // Contenido de Colecciones
            CollectionsTabContent(),
          ],
        ),
        floatingActionButton: _currentIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  // Cambia el contenido del diálogo aquí si deseas algo diferente para colecciones
                  final TextEditingController _collectionNameController =
                      TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.9, // Ajusta el tamaño del diálogo
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Crear nueva colección',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _collectionNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Nombre de la colección',
                                      hintText:
                                          'Ponle un nombre a tu colección',
                                      prefixIcon: Icon(Icons.collections),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Acción para añadir colaboradores
                                          // Puedes implementar lógica adicional aquí
                                        },
                                        icon: const Icon(Icons.group_add),
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        'Añadir Colaboradores',
                                        style: TextStyle(
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final String collectionName =
                                            _collectionNameController.text
                                                .trim();

                                        if (collectionName.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'El nombre de la colección no puede estar vacío'),
                                            ),
                                          );
                                          return;
                                        }

                                        try {
                                          // Guarda la colección en Firebase
                                          await FirebaseFirestore.instance
                                              .collection('Coleccion')
                                              .add({
                                            'Coleccion': collectionName,
                                            'imagenUrl':
                                                'https://via.placeholder.com/150', // Puedes agregar una URL de imagen aquí
                                            'createdAt':
                                                FieldValue.serverTimestamp(),
                                          });

                                          // Cierra el diálogo
                                          Navigator.of(context).pop();

                                          // Muestra un mensaje de éxito
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  '¡Colección creada exitosamente!'),
                                            ),
                                          );
                                        } catch (e) {
                                          // Manejo de errores
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Error al crear la colección: $e'),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: const Text('Crear'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

// Contenido para la pestaña de "Favoritos"
class FavoritesTabContent extends StatelessWidget {
  const FavoritesTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Aquí va el contenido de Favoritos'),
    );
  }
}

// Contenido para la pestaña de "Colecciones"
class CollectionsTabContent extends StatelessWidget {
  const CollectionsTabContent({super.key});

  Future<void> _deleteCollection(BuildContext context, String id) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar colección'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar esta colección?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance
            .collection('Coleccion')
            .doc(id)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Colección eliminada exitosamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar la colección: $e')),
        );
      }
    }
  }

void _openFormulario(BuildContext context, {DocumentSnapshot? usuario}) {
  showDialog(
    context: context,
    builder: (context) => FormularioScreen(usuario: usuario),
  );
}


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Coleccion').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay colecciones disponibles.'));
        }

        final colecciones = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 157 / 104,
          ),
          itemCount: colecciones.length,
          itemBuilder: (context, index) {
            final coleccion = colecciones[index].data() as Map<String, dynamic>;

            return GestureDetector(
              onTap: () {
                // Al hacer clic en el Card, abrir el formulario en modo edición
                _openFormulario(context, usuario: colecciones[index]);
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          coleccion['imagenUrl'] ??
                              'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coleccion['Coleccion'] ?? 'Sin nombre',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const Text(
                            '5 elementos',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla de Explorar'),
    );
  }
}

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  void _navigateToDetailScreen(BuildContext context, DocumentSnapshot grupo) {
    //Navegar a la pantalla de detalles del grupo al presionar la card
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleGruposScreen(grupo: grupo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Comunidades',
            style: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: 34,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 16),
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3.0,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'Grupos'),
              Tab(text: 'Emprendimiento'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGroupsTab(context),
            _buildEntrepreneurshipTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sección "Tus Grupos"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tus Grupos',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FormularioGrupos(),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.secondary,
                mini: true,
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Scroll horizontal para "Tus Grupos"
          SizedBox(
            height: 110,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Grupos')
                  .orderBy('createAt',
                      descending: true) //Se ordena por fecha de creacion
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay grupos creados',
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                  );
                }

                final grupos = snapshot.data!.docs;
                
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: grupos.length,
                  itemBuilder: (context, index) {
                    final grupo = grupos[index];
                    final idGrupo = grupo.id;
                    final nombre = grupo['nombre'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () => _navigateToDetailScreen(context, grupo),
                        child: _groupCard(
                            'https://via.placeholder.com/150', nombre),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Sección "Recomendaciones"
          const Text(
            'Recomendaciones',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins-Regular',
            ),
          ),
          const SizedBox(height: 8),
          _recommendationCard('https://via.placeholder.com/150',
              'Locosporelpapel', '1,1 Mil Miembros', [
            'https://via.placeholder.com/150',
            'https://via.placeholder.com/150',
            'https://via.placeholder.com/150',
          ]),
          _recommendationCard('https://via.placeholder.com/150',
              'Patronestejido', '1,1 Mil Miembros', [
            'https://via.placeholder.com/150',
            'https://via.placeholder.com/150',
            'https://via.placeholder.com/150',
          ]),
          _recommendationCard('https://via.placeholder.com/150',
              'MaquillasanCarlos', '1,1 Mil Miembros', [
            'https://via.placeholder.com/150',
            'https://via.placeholder.com/150',
            'https://via.placeholder.com/150',
          ]),
        ],
      ),
    );
  }

  Widget _buildEntrepreneurshipTab() {
    return const Center(
      child: Text(
        'Contenido de Emprendimiento',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _groupCard(String imageUrl, String title) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins-Regular',
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendationCard(String imageUrl, String title, String members,
      List<String> profileImages) {
    return SizedBox(
      width: 350,
      height: 150,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 112,
                  height: 112,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      members,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Reemplazar texto con fotos de perfil
                    SizedBox(
                      height: 24, // Altura de las fotos de perfil
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: profileImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ClipOval(
                              child: Image.network(
                                profileImages[index],
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla de Mensajes'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pantalla de Perfil'),
    );
  }
}
