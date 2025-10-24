import 'package:capstone/provider/home_provider.dart';
import 'package:capstone/provider/user_provider.dart';
import 'package:capstone/provider/wishlist_provider.dart';
import 'package:capstone/ui/combination_page/combination_page.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/ui/detail_product/detail_product_screen.dart';
import 'package:capstone/ui/login_regist/forgot_pw.dart';
import 'package:capstone/ui/home/home.dart';
import 'package:capstone/ui/login_regist/login.dart';
import 'package:capstone/ui/login_regist/provider/form_validation.dart';
import 'package:capstone/ui/login_regist/provider/loading_provider.dart';
import 'package:capstone/ui/login_regist/provider/visibility_provider.dart';
import 'package:capstone/ui/login_regist/signup.dart';
import 'package:capstone/ui/onboarding/onboarding.dart';
import 'package:capstone/ui/profile/ganti_email/ganti_email.dart';
import 'package:capstone/ui/profile/ganti_nama/ganti_nama.dart';
import 'package:capstone/ui/profile/ganti_password/ganti_password.dart';
import 'package:capstone/ui/profile/profile.dart';
import 'package:capstone/ui/profile/wishlist/wishlist.dart';
import 'package:capstone/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'data/api/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiServices()),
        ChangeNotifierProvider(create: (_) => IngredientsProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) => FormValidationProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (_) => const Login(),
          '/signup': (_) => const RegisterPage(),
          '/forgotpw': (_) => const ForgotPassword(),
          '/home': (_) => const Home(),
          '/product_detail': (_) => const ProductDetailPage(),
          '/profile': (_) => const Profile(),
          '/cek_kombinasi': (_) => const CombinationPage(),
          '/ganti_nama': (_) => const GantiNama(),
          '/ganti_email': (_) => const GantiEmail(),
          '/ganti_password': (_) => const ForgotPasswordPage(),
          '/wishlist': (_) => const WishlistPage(),
        },
        theme: ThemeData(
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff007BFF)),
        ),
      ),
    );
  }
}
