import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:capstone/ui/login_regist/widget/password_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    final bool passwordsMatch =
        _passwordController.text == _confirmController.text &&
        _passwordController.text.isNotEmpty;

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
                    // TITLE 
                    const Text(
                      'Create account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // EMAIL
                    CustomTextField(
                      label: 'Email',
                      hintText: 'helloworld@gmail.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD
                    PasswordTextField(
                      label: 'Password',
                      hintText: 'At least 8 characters',
                      controller: _passwordController,
                      obscurePassword: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // CONFIRM PASSWORD
                    PasswordTextField(
                      label: 'Confirm Password',
                      hintText: 'At least 8 characters',
                      controller: _confirmController,
                      obscurePassword: _obscureConfirm,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),

                    const SizedBox(height: 8),

                    //  ERROR PASSWORD TIDAK SAMA
                    if (!passwordsMatch && _confirmController.text.isNotEmpty)
                      const Text(
                        "Passwords do not match",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),

                    const SizedBox(height: 16),

                    // ACCEPT TERMS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _isAccepted,
                          onChanged: (value) {
                            setState(() => _isAccepted = value ?? false);
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
                    ),

                    const SizedBox(height: 24),

                    // SIGN UP BUTTON
                    ElevatedButton(
                      onPressed: _isAccepted && passwordsMatch
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Account created successfully!',
                                  ),
                                ),
                              );
                            }
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
                      Navigator.pushNamed(context, '/');
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
