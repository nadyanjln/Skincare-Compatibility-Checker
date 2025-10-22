import 'package:capstone/ui/detail_product/widget/all_ingredients_card.dart';
import 'package:capstone/ui/detail_product/widget/product_info_card.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

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

          // Add to Match Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Produk ditambahkan untuk pencocokan'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff007BFF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
                shadowColor: Colors.black.withOpacity(0.2),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shuffle, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Tambahkan untuk Pencocokan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
