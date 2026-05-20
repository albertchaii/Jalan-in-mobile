import 'package:flutter/material.dart';
import 'package:jalan_in/views/shell/home_shell.dart';
import 'package:provider/provider.dart';

import 'package:jalan_in/views/auth/login_screen.dart';
import 'package:jalan_in/providers/auth_provider.dart'; 
import 'package:jalan_in/providers/report_provider.dart';
// IMPORT MAIN SCREEN DIMATIKAN SEMENTARA
// import 'package:jalan_in/views/main_screen.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuthStatus()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
      ],
      child: const JalanInApp(),
    ),
  );
}

class JalanInApp extends StatelessWidget {
  const JalanInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'jalan.in',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF8A0B14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8A0B14),
          primary: const Color(0xFF8A0B14),
        ),
        scaffoldBackgroundColor: const Color(0xFFFEF9F9),
        fontFamily: 'Roboto', 
      ),
      
      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          // 1. Cek loading status
          if (auth.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF8A0B14)),
              ),
            );
          }
          
          // 2. Jika sudah login
          if (auth.isAuthenticated) {
            return const HomeShell();
          }
          
          // 3. Jika belum login
          return const HomeShell();
        },
      ),
    );
  }
}