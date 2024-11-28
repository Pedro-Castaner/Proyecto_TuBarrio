import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class FormularioScreen extends StatefulWidget {
  final DocumentSnapshot? usuario;

  const FormularioScreen({super.key, this.usuario});

  @override
  FormularioScreenState createState() => FormularioScreenState();
}

class FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Si estamos en modo edición, cargamos los datos del usuario en los controladores
    if (widget.usuario != null) {
      final usuarioData = widget.usuario!.data() as Map<String, dynamic>;
      _nombreController.text = usuarioData['nombre'] ?? '';

    }
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar el formulario
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final usuarioData = {
        'nombre': _nombreController.text,

      };

      try {
        if (widget.usuario == null) {
          // Si el usuario es nuevo, lo agregamos a la colección
          await FirebaseFirestore.instance.collection('usuarios').add(usuarioData);

          // Mostrar un SnackBar de confirmación de creación
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario creado correctamente')),
          );
        } else {
          // Si es una edición, actualizamos el documento existente
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(widget.usuario!.id)
              .update(usuarioData);

          // Mostrar un SnackBar de confirmación de edición
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario editado correctamente')),
          );
        }

        Navigator.of(context).pop(); // Cerramos el formulario
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar el usuario')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.usuario == null ? 'Agregar Usuario' : 'Editar Usuario'),
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
        actions: [
          IconButton(
            icon: const Icon(Icons.close), // Ícono de cierre (X)
            onPressed: () {
              Navigator.of(context).pop(); // Cierra la pantalla actual
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32), // Espacio entre campos
      
              const SizedBox(height: 32), // Espacio antes del botón
              ElevatedButton(
                onPressed: _saveUser,
                child: Text(widget.usuario == null ? 'Agregar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
