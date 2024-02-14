import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/presentation/login_page.dart';
import 'firebase_options.dart';
import 'presentation/user_sessions.dart';
import 'presentation/HomePage.dart';
import 'presentation/signup_page.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
    }
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Set this to false to hide the debug banner
       initialRoute: '/user_sessions',
      routes: {
         '/':(context) => LoginPage(),
        '/home': (context) => const home(),
        '/signup':(context) => SignUpPage(),
        '/user_sessions': (context) => UserSessions(), // Dummy parking slot for illustration
        // Add more routes as needed
      },
    );
  }
}

