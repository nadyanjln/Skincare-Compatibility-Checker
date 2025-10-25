import 'package:capstone/provider/user_provider.dart';
import 'package:capstone/ui/login_regist/provider/form_validation.dart';
import 'package:capstone/ui/login_regist/provider/visibility_provider.dart';
import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:capstone/ui/login_regist/widget/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister(BuildContext context) async {
    final formProvider = context.read<FormValidationProvider>();
    final userProvider = context.read<UserProvider>();

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!formProvider.isRegisterFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete the form correctly"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await userProvider.register(name, email, password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      'Create account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // NAME
                    CustomTextField(
                      label: 'Full Name',
                      hintText: 'John Doe',
                      prefixIcon: Icons.person_outline,
                      controller: _nameController,
                      onChanged: (value) {
                        context.read<FormValidationProvider>().setName(value);
                      },
                    ),

                    const SizedBox(height: 20),

                    // EMAIL
                    CustomTextField(
                      label: 'Email',
                      hintText: 'helloworld@gmail.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      onChanged: (value) {
                        context.read<FormValidationProvider>().setEmail(value);
                      },
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, visibilityProvider, child) {
                        return PasswordTextField(
                          label: 'Password',
                          hintText: 'At least 8 characters',
                          controller: _passwordController,
                          obscurePassword: visibilityProvider.obscurePassword,
                          onToggleVisibility: () {
                            visibilityProvider.togglePasswordVisibility();
                          },
                          onChanged: (value) {
                            context.read<FormValidationProvider>().setPassword(
                              value,
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // CONFIRM PASSWORD
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, visibilityProvider, child) {
                        return PasswordTextField(
                          label: 'Confirm Password',
                          hintText: 'At least 8 characters',
                          controller: _confirmController,
                          obscurePassword:
                              visibilityProvider.obscureConfirmPassword,
                          onToggleVisibility: () {
                            visibilityProvider
                                .toggleConfirmPasswordVisibility();
                          },
                          onChanged: (value) {
                            context
                                .read<FormValidationProvider>()
                                .setConfirmPassword(value);
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // PASSWORD MISMATCH WARNING
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

                    const SizedBox(height: 16),

                    // ACCEPT TERMS
                    Consumer<FormValidationProvider>(
                      builder: (context, formProvider, child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: formProvider.termsAccepted,
                              onChanged: (value) {
                                formProvider.setTermsAccepted(value ?? false);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              activeColor: Colors.black,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'I accept the terms and privacy policy',
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // SIGN UP BUTTON
                    Consumer<FormValidationProvider>(
                      builder: (context, formProvider, child) {
                        return ElevatedButton(
                          onPressed: formProvider.isRegisterFormValid
                              ? () => _handleRegister(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff007BFF),
                            disabledBackgroundColor: const Color(0xffC4C4C4),
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
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
