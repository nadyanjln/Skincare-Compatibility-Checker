import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class GantiEmail extends StatefulWidget {
  const GantiEmail({super.key});

  @override
  State<GantiEmail> createState() => _GantiEmailState();
}

class _GantiEmailState extends State<GantiEmail> {
  final TextEditingController _emailController = TextEditingController(
    text: "helloworld@gmail.com",
  );

  void _handleSubmit() {
    FocusScope.of(context).unfocus(); // tutup keyboard dulu

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Email reset to ${_emailController.text}")),
    );

    // tunggu frame stabil baru pop
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol kembali
              GestureDetector(
                onTap: () => Navigator.pop(context),
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
              const SizedBox(height: 32),

              // Judul halaman
              const Text(
                "Reset Email",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Subjudul
              const Text(
                "Please type something you’ll remember",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 32),

              // Input email pakai CustomTextField
              CustomTextField(
                label: "New Email address",
                hintText: "Enter new email",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // Tombol tetap di bawah layar
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Reset email",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
