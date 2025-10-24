import 'package:capstone/ui/combination_page/widget/ingredient_list.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/ui/combination_page/widget/manual_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bottom_navbar.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({super.key});

  void _handleCameraAction(BuildContext context) {
    // Navigate to camera OCR page
    Navigator.pushNamed(context, '/camera_ocr');
  }

  void _showClearAllDialog(BuildContext context) {
    final provider = context.read<IngredientsProvider>();

    if (!provider.hasIngredients) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No ingredients to remove'),
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
          title: const Text('Delete All'),
          content: const Text(
            'Are you sure you want to delete all ingredients?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                provider.clearAll();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All ingredients have been deleted'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                'Delete',
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
              Text('Please add ingredients first'),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Checking ${provider.ingredientsCount} ingredients...'),
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
                          ? "Delete All (${provider.ingredientsCount})"
                          : "Delete All",
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
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            physics: Provider.of<IngredientsProvider>(context).hasIngredients
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                ManualInputWidget(
                  onCameraPressed: () => _handleCameraAction(context),
                ),
                const SizedBox(height: 16),

                // Gunakan ukuran dinamis agar bisa scroll saat kosong
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const IngredientListWidget(),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // Tombol "Check Combination"
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
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
