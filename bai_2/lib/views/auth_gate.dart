import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../repositories/firebase_auth_repository.dart';
import 'home_view.dart';
import 'login_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = FirebaseAuthRepository();

    return StreamBuilder<AppUser?>(
      stream: repository.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) {
          return const LoginView();
        }

        return HomeView(user: user);
      },
    );
  }
}