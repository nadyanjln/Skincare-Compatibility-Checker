import 'package:capstone/ui/widget/custom_textfield.dart';
import 'package:capstone/ui/widget/password_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    // Tambahkan listener supaya tombol bisa aktif saat user mengetik
    _emailController.addListener(_updateState);
    _passwordController.addListener(_updateState);
    _confirmController.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get passwordsMatch =>
      _passwordController.text == _confirmController.text &&
      _passwordController.text.isNotEmpty;

  bool get isFormFilled =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please type something you’ll remember',
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
                    PasswordTextField(
                      label: 'New password',
                      hintText: 'must be 8 characters',
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
                      label: 'Confirm new password',
                      hintText: 'repeat password',
                      controller: _confirmController,
                      obscurePassword: _obscureConfirm,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),

                    const SizedBox(height: 8),

                    if (!passwordsMatch && _confirmController.text.isNotEmpty)
                      const Text(
                        "Passwords do not match",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),

                    const SizedBox(height: 24),

                    // RESET BUTTON
                    ElevatedButton(
                      onPressed: isFormFilled && passwordsMatch
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Password reset successfully!'),
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
                        'Reset password',
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
                  const Text("Remember your account? "),
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
