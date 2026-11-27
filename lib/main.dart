import 'package:flutter/material.dart';

import 'screens/inspeccion_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Practica09App());
}

class Practica09App extends StatelessWidget {
  const Practica09App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Práctica 9 - Cámara y Sensores',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
      ),
      home: const InspeccionScreen(),
    );
  }
}
