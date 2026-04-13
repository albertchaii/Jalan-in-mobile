import 'package:flutter/material.dart';
import 'views/auth/login_screen.dart'; 
import 'views/auth/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner "DEBUG" di pojok kanan atas
      title: 'jalan.in',
      theme: ThemeData(
        fontFamily: 'Roboto', 
      ),
      home: const MapScreen(), // Memanggil layar login
    );
  }
}