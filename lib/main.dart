import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teencu/wrapper/auth_wrapper.dart';
import 'dart:async';
import 'sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyDucwHqIIOOCKDg3qpLjtCw1-8OfREnu4Q",
      authDomain: "teencu.firebaseapp.com",
      projectId: "teencu",
      storageBucket: "teencu.firebasestorage.app",
      messagingSenderId: "341428856100",
      appId: "1:341428856100:web:fd44031df060ccc7afffb1",
      measurementId: "G-EYCBERYH7Z"
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFC0CB), // Pink background color
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/teencu_icon.png',
                height: 250, // Sesuaikan ukuran sesuai kebutuhan
              ),
              Image.asset(
                'assets/teencu_logo.png',
                height: 250, // Sesuaikan ukuran sesuai kebutuhan
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text("Welcome to Teencu!"),
      ),
    );
  }
}
