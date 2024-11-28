import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalleGruposScreen extends StatefulWidget {
  final DocumentSnapshot grupo;

  const DetalleGruposScreen({super.key, required this.grupo});

  @override
  _DetalleGruposScreenState createState() => _DetalleGruposScreenState();
}

class _DetalleGruposScreenState extends State<DetalleGruposScreen> {
  Future<void> _eliminarGrupo(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Eliminar grupo',
            style: TextStyle(fontFamily: 'Poppins-Regular'),
          ),
          content: const Text(
            '¿Estás seguro de que deseas eliminar este grupo?',
            style: TextStyle(fontFamily: 'Poppins-Regular'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Eliminar',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance
            .collection('Grupos')
            .doc(widget.grupo.id)
            .delete();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Grupo eliminado exitosamente',
                style: TextStyle(fontFamily: 'Poppins-Regular'),
              ),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(8),
            ),
          );

          Navigator.of(context).pop(); // Regresar a la pantalla anterior
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error al eliminar grupo: $e',
                style: const TextStyle(fontFamily: 'Poppins-Regular'),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(8),
            ),
          );
        }
      }
    }
  }

  Future<void> _editarGrupo(BuildContext context) async {
    final TextEditingController nombreController =
        TextEditingController(text: widget.grupo['nombre']);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Editar nombre del grupo',
          style: TextStyle(fontFamily: 'Poppins-Regular'),
        ),
        content: TextField(
          controller: nombreController,
          decoration: const InputDecoration(labelText: 'Nuevo nombre del grupo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(fontFamily: 'Poppins-Regular'),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('Grupos')
                    .doc(widget.grupo.id)
                    .update({'nombre': nombreController.text.trim()});

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Nombre del grupo editado exitosamente',
                        style: TextStyle(fontFamily: 'Poppins-Regular'),
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(8),
                    ),
                  );
                }

                Navigator.of(context).pop();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error al editar nombre del grupo: $e',
                        style: const TextStyle(fontFamily: 'Poppins-Regular'),
                      ),
                    ),
                  );
                }
              }
            },
            child: const Text(
              'Guardar',
              style: TextStyle(fontFamily: 'Poppins-Regular'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Row(
          children: [
            // Aquí está el CircleAvatar que puedes usar para el logo o imagen de perfil del grupo
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Puedes cambiar esta URL por la del grupo
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.group,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.grupo['nombre'],
                style: const TextStyle(
                    fontFamily: 'Poppins-Regular', fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'editar') {
                _editarGrupo(context);
              } else if (value == 'eliminar') {
                _eliminarGrupo(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'editar',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(
                    'Editar grupo',
                    style: TextStyle(fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'eliminar',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text(
                    'Eliminar grupo',
                    style: TextStyle(fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                ChatBubble(
                  name: 'Francisca Barraza',
                  message:
                      'Quiero empezar un nuevo proyecto, no sé si realizar un chaleco o un gorro ¿alguien sabe de alguien que venda patrones?',
                ),
                SizedBox(height: 16.0),
                ChatBubble(
                  name: 'Belén Vega',
                  message:
                      'Yo tengo los dos patrones, te recomiendo para este invierno un gorro de lana ya que te servirá para estas lluvias. Puedes revisar los patrones en mi cuenta.',
                ),
                SizedBox(height: 16.0),
                ChatBubble(
                  name: 'Francisca Barraza',
                  message: '¡Muchas gracias! ¡Los revisaré!',
                ),
              ],
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String name;
  final String message;

  const ChatBubble({
    required this.name,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Escribe algo...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_a_photo_rounded),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
