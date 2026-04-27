import 'package:flutter/material.dart';
import 'views/auth/login_screen.dart';
import 'package:jalan_in/core/theme/app_theme.dart';

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
      theme: AppTheme.lightTheme,
      home: const LoginScreen(), // Memanggil layar login
    );
  }
}