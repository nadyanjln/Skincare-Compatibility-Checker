import 'package:capstone/provider/user_provider.dart';
import 'package:capstone/ui/login_regist/provider/form_validation.dart';
import 'package:capstone/ui/login_regist/provider/loading_provider.dart';
import 'package:capstone/ui/login_regist/provider/visibility_provider.dart';
import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:capstone/ui/login_regist/widget/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

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
    _confirmController.addListener(() {
      context.read<FormValidationProvider>().setConfirmPassword(
        _confirmController.text,
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final formProvider = context.read<FormValidationProvider>();
    final userProvider = context.read<UserProvider>();
    final loadingProvider = context.read<LoadingProvider>();

    final email = _emailController.text.trim();
    final newPassword = _passwordController.text.trim();

    if (!formProvider.isResetFormValid) {
      String message = 'Please fill in all fields.';
      if (!formProvider.isEmailValid) {
        message = 'Please enter a valid email address.';
      } else if (!formProvider.isPasswordValid) {
        message = 'Password must be at least 8 characters.';
      } else if (!formProvider.doPasswordsMatch) {
        message = 'Passwords do not match.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
      return;
    }

    loadingProvider.setLoading(true);

    final success = await userProvider.resetPassword(email, newPassword);

    loadingProvider.setLoading(false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to reset password. Please try again.'),
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
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please type something you'll remember",
                      style: TextStyle(color: Color(0xff4A4A4B)),
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

                    // NEW PASSWORD
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, passwordProvider, child) {
                        return PasswordTextField(
                          label: 'New password',
                          hintText: 'must be 8 characters',
                          controller: _passwordController,
                          obscurePassword: passwordProvider.obscurePassword,
                          onToggleVisibility: () {
                            passwordProvider.togglePasswordVisibility();
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // CONFIRM PASSWORD
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, passwordProvider, child) {
                        return PasswordTextField(
                          label: 'Confirm new password',
                          hintText: 'repeat password',
                          controller: _confirmController,
                          obscurePassword:
                              passwordProvider.obscureConfirmPassword,
                          onToggleVisibility: () {
                            passwordProvider.toggleConfirmPasswordVisibility();
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // ERROR MESSAGE
                    Consumer<FormValidationProvider>(
                      builder: (context, formProvider, child) {
                        if (!formProvider.doPasswordsMatch &&
                            formProvider.confirmPassword.isNotEmpty) {
                          return const Text(
                            "Passwords do not match",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    const SizedBox(height: 24),

                    // RESET BUTTON
                    Consumer2<FormValidationProvider, LoadingProvider>(
                      builder: (context, formProvider, loadingProvider, child) {
                        final isEnabled =
                            formProvider.isResetFormValid &&
                            !loadingProvider.isLoading;

                        return ElevatedButton(
                          onPressed: isEnabled ? _resetPassword : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff007BFF),
                            disabledBackgroundColor: const Color(0xffC4C4C4),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Reset password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ALREADY HAVE ACCOUNT
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remember your account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
