import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/HomePage.dart';
import 'package:flutter_application_1/presentation/login_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            // User is not signed in, navigate to login page
            return LoginPage();
          } else {
            // User is signed in, navigate to home screen
            return const home();
          }
        }

        // Loading indicator or some other UI element while checking authentication state
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}