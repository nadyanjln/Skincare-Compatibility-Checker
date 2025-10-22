import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:capstone/data/category_data.dart';
import 'package:capstone/ui/detail_product/widget/ingredient_card.dart';
import 'package:provider/provider.dart';


class ProductInfoCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final String category;
  final List<Map<String, dynamic>>? keyIngredients;

  const ProductInfoCard({
    super.key,
    required this.product,
    required this.category,
    this.keyIngredients,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil icon berdasarkan kategori
    final categoryData = categories.firstWhere(
      (cat) => cat['label'] == category,
      orElse: () => {'icon': Icons.category},
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Gambar produk
              Image.asset(
                product['image'],
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Badge kategori
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    categoryData['icon'],
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Nama produk
              Text(
                product['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),

              // Key Ingredients
              if (keyIngredients != null && keyIngredients!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.science,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Key Ingredients',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...keyIngredients!.asMap().entries.map((entry) {
                      final index = entry.key;
                      final ingredient = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index < keyIngredients!.length - 1 ? 12 : 0,
                        ),
                        child: IngredientCard(
                          title: ingredient['name'] ?? '',
                          description: ingredient['description'] ?? '',
                        ),
                      );
                    }).toList(),
                  ],
                ),
            ],
          ),

          // Tombol Wishlist (pakai Provider)
          Positioned(
            right: 8,
            top: 8,
            child: Consumer<WishlistProvider>(
              builder: (context, wishlistProvider, _) {
                // Buat model produk untuk disimpan di provider
                final productItem = ProductIngredient(
                  name: product['name'] ?? '',
                  brand: product['brand'] ?? '',
                  image: product['image'] ?? '',
                  ingredients: product['ingredients'] ?? [],
                );

                final isInWishlist = wishlistProvider.isInWishlist(
                  productItem.name,
                  productItem.brand,
                );

                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff007BFF),
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        wishlistProvider.toggleWishlist(productItem);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isInWishlist
                                  ? '${productItem.name} removed from Wishlist 💔'
                                  : '${productItem.name} added to Wishlist ❤️',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xff007BFF),
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
