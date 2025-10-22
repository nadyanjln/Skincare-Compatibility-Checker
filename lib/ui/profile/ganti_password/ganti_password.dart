import 'package:capstone/ui/login_regist/provider/form_validation.dart';
import 'package:capstone/ui/login_regist/provider/visibility_provider.dart';
import 'package:capstone/ui/login_regist/widget/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    final formProvider = context.read<FormValidationProvider>();

    if (formProvider.password.isEmpty || formProvider.confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields.")),
      );
      return;
    }
    if (!formProvider.isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 8 characters."),
        ),
      );
      return;
    }
    if (!formProvider.doPasswordsMatch) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match.")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password has been reset successfully.")),
    );

    // Reset provider state sebelum kembali
    formProvider.reset();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol kembali
              GestureDetector(
                onTap: () {
                  // Reset provider state saat kembali
                  context.read<FormValidationProvider>().reset();
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB7B4B4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "Reset password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Please type something you'll remember",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // New Password Field
              Consumer<PasswordVisibilityProvider>(
                builder: (context, visibilityProvider, child) {
                  return PasswordTextField(
                    label: "New password",
                    hintText: "must be 8 characters",
                    obscurePassword: visibilityProvider.obscurePassword,
                    controller: _newPasswordController,
                    onToggleVisibility: () {
                      visibilityProvider.togglePasswordVisibility();
                    },
                    onChanged: (value) {
                      context.read<FormValidationProvider>().setPassword(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              // Confirm Password Field
              Consumer<PasswordVisibilityProvider>(
                builder: (context, visibilityProvider, child) {
                  return PasswordTextField(
                    label: "Confirm new password",
                    hintText: "repeat password",
                    obscurePassword: visibilityProvider.obscureConfirmPassword,
                    controller: _confirmPasswordController,
                    onToggleVisibility: () {
                      visibilityProvider.toggleConfirmPasswordVisibility();
                    },
                    onChanged: (value) {
                      context.read<FormValidationProvider>().setConfirmPassword(
                        value,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 60),

              // Reset Password Button
              Consumer<FormValidationProvider>(
                builder: (context, formProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: formProvider.isResetFormValid
                          ? _resetPassword
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff007BFF),
                        disabledBackgroundColor: const Color(0xffC4C4C4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Reset password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
