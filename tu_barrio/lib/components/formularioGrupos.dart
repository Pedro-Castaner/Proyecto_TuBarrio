import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioGrupos extends StatefulWidget {
  const FormularioGrupos({Key? key}) : super(key: key);

  @override
  State<FormularioGrupos> createState() => _FormularioGruposState();
}

class _FormularioGruposState extends State<FormularioGrupos> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();

  Future<void> _agregarGrupo() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('Grupos').add({
          'nombre': _nombreController.text.trim(),
          'createAt': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          // Verifica si el widget sigue montado
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Grupo creado exitosamente')),
          );

          Navigator.of(context)
              .pop(); // Cierra el formulario después de agregar
        }
      } catch (e) {
        if (mounted) {
          // Verifica si el widget sigue montado
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al crear el grupo: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear nuevo grupo',
          style: TextStyle(
            fontFamily: 'Poppins-Regular',
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del grupo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _agregarGrupo,
                  child: const Text(
                    'Crear grupo',
                    style: TextStyle(fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }
}
