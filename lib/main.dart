import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'my_vehicle_page.dart';
import 'HomePage.dart';
void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
    
      // Add more routes as needed
    }
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Set this to false to hide the debug banner
       initialRoute: '/',
      routes: {
        '/': (context) => const AuthenticationWrapper(), // New route for authentication wrapper
        '/home': (context) => const HomePage(),
        '/myvehicle': (context) => const MyVehiclePage(parkingSlot: "A1"), // Dummy parking slot for illustration
        // Add more routes as needed
      },
    );
  }
}

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
            return const HomePage();
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


  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //runApp(const MyApp());


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
