import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas/screens/beranda.dart';
import 'package:uas/screens/forgot.dart';
import 'package:uas/screens/regist.dart';
import 'package:uas/screens/verify.dart';
import 'firebase_options.dart'; // Import the generated firebase_options.dart
import 'screens/login.dart'; // Import LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase with platform-specific options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Log an error message if Firebase initialization fails
    debugPrint("Firebase initialization failed: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/forgot': (context) => ForgotPasswordScreen(),
        '/beranda': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/verify': (context) => const VerifyOTPScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green, // Set a default color theme
      ),
    );
  }
}
