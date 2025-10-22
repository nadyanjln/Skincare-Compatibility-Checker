import 'package:capstone/ui/combination_page/widget/ingredient_list.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/ui/combination_page/widget/manual_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bottom_navbar.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({super.key});

  void _handleCameraAction(BuildContext context) {
    // TODO: Implementasi aksi kamera
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur kamera akan segera tersedia'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    final provider = context.read<IngredientsProvider>();

    if (!provider.hasIngredients) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak ada kandungan untuk dihapus'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Hapus Semua'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus semua kandungan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                provider.clearAll();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Semua kandungan telah dihapus'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffF9FAFB),
        elevation: 0,
        title: const Text(
          "Lab",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Consumer<IngredientsProvider>(
              builder: (context, provider, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffE5E7EB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton.icon(
                    onPressed: () => _showClearAllDialog(context),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.black54,
                    ),
                    label: Text(
                      provider.hasIngredients
                          ? "Hapus Semua (${provider.ingredientsCount})"
                          : "Hapus Semua",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          children: [
            // Input Container
            ManualInputWidget(
              onCameraPressed: () => _handleCameraAction(context),
            ),
            const SizedBox(height: 16),

            // List Kandungan
            const Expanded(child: IngredientListWidget()),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cek_kombinasi');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
