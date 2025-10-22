import 'package:capstone/ui/combination_page/combination_page.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/ui/detail_product/detail_product_screen.dart';
import 'package:capstone/ui/login_regist/forgot_pw.dart';
import 'package:capstone/ui/home/home.dart';
import 'package:capstone/ui/login_regist/login.dart';
import 'package:capstone/ui/login_regist/signup.dart';
import 'package:capstone/ui/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => IngredientsProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/signup': (context) => const RegisterPage(),
          '/forgotpw': (context) => const ForgotPassword(),
          '/home': (context) => const Home(),
          '/product_detail': (context) => const ProductDetailPage(),
          '/profile': (_) => const Profile(),
          '/cek_kombinasi': (_) => const CombinationPage(),
        },
        theme: ThemeData(
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff007BFF)),
        ),
      ),
    );
  }
}
