import 'package:capstone/ui/detail_product/widget/all_ingredients_card.dart';
import 'package:capstone/ui/detail_product/widget/product_info_card.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  void _addToLab(BuildContext context, Map<String, dynamic> product) {
    final provider = context.read<IngredientsProvider>();

    // Extract ingredients list from product
    List<String> ingredientsList = [];

    // Get from allIngredients string if available
    final allIngredients = product['allIngredients'] as String?;
    if (allIngredients != null && allIngredients.isNotEmpty) {
      // Split by comma and clean up
      ingredientsList = allIngredients
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    // Or get from keyIngredients if available
    if (ingredientsList.isEmpty) {
      final keyIngredients =
          product['keyIngredients'] as List<Map<String, dynamic>>?;
      if (keyIngredients != null) {
        ingredientsList = keyIngredients
            .map((ingredient) => ingredient['name'] as String)
            .toList();
      }
    }

    final productName = product['name'] ?? 'Unknown Product';
    final productBrand = product['brand'] ?? 'Unknown Brand';

    // Check if product already exists
    if (provider.hasProduct(productName, productBrand)) {
      // Show info message that product already exists
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$productName sudah ada di Lab',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Lihat',
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/cek_kombinasi');
            },
          ),
        ),
      );
      return;
    }

    // Add product to provider
    final added = provider.addProduct(
      productName,
      productBrand,
      product['image'] ?? '',
      ingredients: ingredientsList,
    );

    if (added) {
      // Show success message with navigation option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.science, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$productName ditambahkan ke Lab',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xff007BFF),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Lihat',
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/cek_kombinasi');
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final keyIngredients =
        product['keyIngredients'] as List<Map<String, dynamic>>?;
    final allIngredients = product['allIngredients'] as String?;
    final category = product['category'] ?? 'Cleansing';

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product Info Card with Key Ingredients
                    ProductInfoCard(
                      product: product,
                      category: category,
                      keyIngredients: keyIngredients,
                    ),
                    const SizedBox(height: 24),

                    // All Ingredients Card
                    if (allIngredients != null && allIngredients.isNotEmpty)
                      AllIngredientsCard(allIngredients: allIngredients),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // Add to Lab Button with dynamic state
          Consumer<IngredientsProvider>(
            builder: (context, provider, child) {
              final productName = product['name'] ?? 'Unknown Product';
              final productBrand = product['brand'] ?? 'Unknown Brand';
              final isInLab = provider.hasProduct(productName, productBrand);

              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF9FAFB),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: SafeArea(
                    top: false,
                    child: ElevatedButton(
                      onPressed: isInLab
                          ? () {
                              // Navigate to lab if already added
                              Navigator.pushReplacementNamed(
                                context,
                                '/cek_kombinasi',
                              );
                            }
                          : () => _addToLab(context, product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isInLab
                            ? Colors.grey.shade400
                            : const Color(0xff007BFF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isInLab ? Icons.check_circle : Icons.science,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isInLab ? 'Sudah di Lab' : 'Add to Lab',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
