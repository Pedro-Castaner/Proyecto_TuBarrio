import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioScreen extends StatefulWidget {
  final DocumentSnapshot? usuario;

  const FormularioScreen({super.key, this.usuario});

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Precargar datos en caso de edición
    if (widget.usuario != null) {
      final data = widget.usuario!.data() as Map<String, dynamic>;
      _nombreController.text = data['Coleccion'] ?? '';
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final usuarioData = {'Coleccion': _nombreController.text};
      try {
        if (widget.usuario == null) {
          // Crear un nuevo documento
          await FirebaseFirestore.instance.collection('Coleccion').add(usuarioData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Colección creada exitosamente')),
          );
        } else {
          // Actualizar un documento existente
          await FirebaseFirestore.instance
              .collection('Coleccion')
              .doc(widget.usuario!.id)
              .update(usuarioData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Colección actualizada correctamente')),
          );
        }
        Navigator.of(context).pop(); // Cerrar diálogo
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _deleteCollection() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar colección'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar esta colección? Esta acción no se puede deshacer.'),
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
            .doc(widget.usuario!.id)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Colección eliminada exitosamente')),
        );
        Navigator.of(context).pop(); // Cerrar diálogo tras eliminar
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.usuario == null ? 'Agregar Colección' : 'Editar Colección',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre Colección'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Por favor ingrese un nombre'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.usuario != null)
                        ElevatedButton(
                          onPressed: _deleteCollection,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('Eliminar'),
                        ),
                      ElevatedButton(
                        onPressed: _saveUser,
                        child: Text(widget.usuario == null ? 'Agregar' : 'Actualizar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
