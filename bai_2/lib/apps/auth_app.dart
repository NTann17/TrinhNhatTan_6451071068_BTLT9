import 'package:flutter/material.dart';

import '../views/auth_gate.dart';
import '../widgets/app_theme.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bai 2 - Authentication',
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}