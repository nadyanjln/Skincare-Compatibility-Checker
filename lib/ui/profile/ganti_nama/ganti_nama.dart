import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class GantiNama extends StatefulWidget {
  const GantiNama({super.key});

  @override
  State<GantiNama> createState() => _GantiNamaState();
}

class _GantiNamaState extends State<GantiNama> {
  final TextEditingController _nameController = TextEditingController(
    text: "Nadya",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100,
          ),
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
                "Reset Name",
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

              // Input pakai CustomTextField
              CustomTextField(
                label: "New Name",
                hintText: "Enter new name",
                prefixIcon: Icons.person_outline,
                controller: _nameController,
              ),
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
            onPressed: () {
              FocusScope.of(context).unfocus(); // Tutup keyboard

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Name reset to ${_nameController.text}"),
                ),
              );

              // langsung balik setelah snackbar muncul sebentar
              Future.delayed(const Duration(milliseconds: 300), () {
                Navigator.pop(context, _nameController.text);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Reset name",
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
