import 'package:capstone/ui/forgot_pw.dart';
import 'package:capstone/ui/home.dart';
import 'package:capstone/ui/login.dart';
import 'package:capstone/ui/profile.dart';
import 'package:capstone/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/signup': (context) => const RegisterPage(),
        '/forgotpw': (context) => const ForgotPassword(),
        '/home': (context) => const Home(),
        '/profile': (_) => const Profile(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff007BFF)),
      ),
    );
  }
}
