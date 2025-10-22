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

  void _handleCheckCombination(BuildContext context) {
    final provider = context.read<IngredientsProvider>();

    if (!provider.hasIngredients) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Tambahkan kandungan terlebih dahulu'),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // TODO: Navigate to result page or process combination
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Mengecek ${provider.ingredientsCount} kandungan...'),
          ],
        ),
        backgroundColor: const Color(0xff007BFF),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
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
      body: Stack(
        children: [
          Padding(
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

                // Extra padding to prevent content from being hidden behind button
                const SizedBox(height: 80),
              ],
            ),
          ),

          // Floating Check Combination Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 20, // Position above bottom navbar
            child: Consumer<IngredientsProvider>(
              builder: (context, provider, child) {
                return AnimatedOpacity(
                  opacity: provider.hasIngredients ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff007BFF).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => _handleCheckCombination(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff007BFF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.analytics_outlined, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            provider.hasIngredients
                                ? 'Check Combination (${provider.ingredientsCount})'
                                : 'Check Combination',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
