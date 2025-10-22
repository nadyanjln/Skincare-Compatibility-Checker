import 'package:capstone/provider/user_provider.dart';
import 'package:capstone/ui/login_regist/provider/form_validation.dart';
import 'package:capstone/ui/login_regist/provider/loading_provider.dart';
import 'package:capstone/ui/login_regist/provider/visibility_provider.dart';
import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:capstone/ui/login_regist/widget/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset providers saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FormValidationProvider>().reset();
      context.read<PasswordVisibilityProvider>().reset();
      context.read<LoadingProvider>().setLoading(false);
    });

    // Listen to text changes dan update provider
    _emailController.addListener(() {
      context.read<FormValidationProvider>().setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      context.read<FormValidationProvider>().setPassword(
        _passwordController.text,
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final formProvider = context.read<FormValidationProvider>();
    final userProvider = context.read<UserProvider>();
    final loadingProvider = context.read<LoadingProvider>();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!formProvider.isLoginFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    loadingProvider.setLoading(true);

    final success = await userProvider.login(email, password);

    loadingProvider.setLoading(false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // EMAIL
                      CustomTextField(
                        label: 'Email address',
                        hintText: 'helloworld@gmail.com',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD
                      Consumer<PasswordVisibilityProvider>(
                        builder: (context, passwordProvider, child) {
                          return PasswordTextField(
                            label: 'Password',
                            hintText: 'At least 8 characters',
                            controller: _passwordController,
                            obscurePassword: passwordProvider.obscurePassword,
                            onToggleVisibility: () {
                              passwordProvider.togglePasswordVisibility();
                            },
                          );
                        },
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgotpw');
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // LOGIN BUTTON
                      Consumer2<FormValidationProvider, LoadingProvider>(
                        builder:
                            (context, formProvider, loadingProvider, child) {
                              final isEnabled =
                                  formProvider.isLoginFormValid &&
                                  !loadingProvider.isLoading;

                              return ElevatedButton(
                                onPressed: isEnabled ? _login : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff007BFF),
                                  disabledBackgroundColor: const Color(
                                    0xffC4C4C4,
                                  ),
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: loadingProvider.isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text(
                                        'Log in',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                              );
                            },
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: const [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.black12),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Or login with',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.black12),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "The 'Login with Google' feature will be available soon.",
                              ),
                              backgroundColor: Colors.blueAccent,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Image.asset('assets/google_logo.png', height: 20),
                        label: const Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          side: const BorderSide(color: Color(0xffD8DADC)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
