import 'package:bazi_app_frontend/screens/authenticated_screen.dart';
import 'package:bazi_app_frontend/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class AuthHandlerScreen extends StatelessWidget {
  const AuthHandlerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const WelcomeScreen();
          } else {
            return const AuthenticatedScreen();
          }
        }
        return Scaffold(
          body: Center(
            child: loadingWidget(),
          ),
        );
      },
    );
  }
}
