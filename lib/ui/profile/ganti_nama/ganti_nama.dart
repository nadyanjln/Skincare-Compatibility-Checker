import 'package:capstone/ui/login_regist/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/provider/user_provider.dart';

class GantiNama extends StatefulWidget {
  const GantiNama({super.key});

  @override
  State<GantiNama> createState() => _GantiNamaState();
}

class _GantiNamaState extends State<GantiNama> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ambil nama awal dari provider
    final user = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = user.name ?? "User";
  }

  void _handleSubmit() {
    FocusScope.of(context).unfocus(); // Tutup keyboard

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateName(_nameController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Name updated to ${_nameController.text}")),
    );

    // Tutup halaman dengan sedikit delay agar animasi SnackBar muncul dulu
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      resizeToAvoidBottomInset:
          true, // ✅ Supaya tampilan menyesuaikan saat keyboard muncul

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                // Tambahkan padding bawah agar tidak tertutup keyboard
                bottom: MediaQuery.of(context).viewInsets.bottom + 100,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
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
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
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

                      const Text(
                        "Please type something you’ll remember",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Input nama baru
                      CustomTextField(
                        label: "New Name",
                        hintText: "Enter new name",
                        prefixIcon: Icons.person_outline,
                        controller: _nameController,
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // Tombol bawah
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          // Tambahkan jarak sesuai tinggi keyboard + margin bawah
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
