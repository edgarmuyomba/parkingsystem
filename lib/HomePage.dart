import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome home'),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => 
                Navigator.pushNamed(context, '/myvehicle'),
        

              child: const Text('View my Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
