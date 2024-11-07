// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tu_barrio/screens/home.dart';
import 'package:tu_barrio/screens/splashscreen.dart'; // Importa el archivo splashscreen.dart
import 'package:tu_barrio/theme/theme.dart'; // Importa el tema
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Usa el tema claro
      darkTheme: AppTheme.darkTheme, // Usa el tema oscuro
      themeMode: ThemeMode.system, // Cambia según la configuración del sistema
      home: const SplashScreen(), // La primera pantalla será el SplashScreen
    );
  }
}

// Aquí tienes la pantalla que será el home después del splash
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Mantenedor(); // Usa el ChatsScreen en lugar de la lista
  }
}
