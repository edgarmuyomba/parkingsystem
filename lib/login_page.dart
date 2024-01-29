// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If the login is successful, navigate to another screen or perform desired action
      //Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error: $e");

      // Handle login errors, e.g., show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login failed. Check your credentials."),
      ));
    }
  }

  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If the sign-up is successful, you may want to automatically log in the user
      _signInWithEmailAndPassword(context);
    } catch (e) {
      print("Error: $e");

      // Handle sign-up errors, e.g., show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sign-up failed. Check your credentials."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              child: const Text('Login'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _signUpWithEmailAndPassword(context),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}




void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/home': (context) => const HomePage(),
      // Add more routes as needed
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}

Future<void>
signInWithEmailAndPassword(String email, String password) async {
  try {
    await
FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);
  } catch (e) {
    print("Error: $e");
  }
}

