import 'package:flutter/material.dart';
import 'registration_page.dart'; // Должен быть импорт!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Темная тема (лучше для неонового дизайна)
      home: RegistrationPage(), // Здесь должен быть наш экран!
    );
  }
}
