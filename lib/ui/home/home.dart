import 'package:capstone/ui/bottom_navbar.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/provider/wishlist_provider.dart';
import 'package:capstone/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:capstone/ui/home/widget/category_item.dart';
import 'package:capstone/data/product_data.dart';
import 'package:capstone/data/category_data.dart';
import 'package:capstone/ui/home/widget/product_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  void _addToLab(BuildContext context, Map<String, dynamic> product) {
    final provider = context.read<IngredientsProvider>();

    provider.addProduct(
      product['name'],
      product['brand'],
      product['image'],
      ingredients: product['ingredients'] ?? [],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.science, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${product['name']} has been added to the Lab',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff007BFF),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/cek_kombinasi');
          },
        ),
      ),
    );
  }

  void _handleCameraSearch(BuildContext context) {
    // Navigate to camera OCR page
    print("Camera icon pressed!");
    Navigator.pushNamed(context, '/camera_ocr');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, WishlistProvider>(
      builder: (context, homeProvider, wishlistProvider, child) {
        // Filter products by category
        final filteredProducts = homeProvider.selectedCategoryIndex == 0
            ? products
            : products
                  .where(
                    (p) =>
                        p['category'] ==
                        categories[homeProvider.selectedCategoryIndex]['label'],
                  )
                  .toList();

        return Scaffold(
          backgroundColor: const Color(0xffF9FAFB),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () => _handleCameraSearch(context),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🏷️ Category selector
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(categories.length, (index) {
                        final item = categories[index];
                        return GestureDetector(
                          onTap: () => homeProvider.setSelectedCategory(index),
                          child: CategoryItem(
                            icon: item['icon'],
                            label: item['label'],
                            isSelected:
                                index == homeProvider.selectedCategoryIndex,
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🧴 Product grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.55,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      // Buat ProductIngredient object untuk wishlist
                      final productIngredient = ProductIngredient(
                        name: product['name'],
                        brand: product['brand'],
                        image: product['image'],
                        ingredients: product['ingredients'] ?? [],
                      );

                      final isWishlisted = wishlistProvider.isInWishlist(
                        product['name'],
                        product['brand'],
                      );

                      return ProductCard(
                        image: product['image'],
                        name: product['name'],
                        brand: product['brand'],
                        isWishlisted: isWishlisted,
                        onWishlistToggle: () {
                          wishlistProvider.toggleWishlist(productIngredient);
                        },
                        onAdd: () => _addToLab(context, product),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/product_detail',
                            arguments: product,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom navigation bar
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 0,
            onTap: (index) {
              if (index == 0) return;
              if (index == 1) {
                Navigator.pushReplacementNamed(context, '/cek_kombinasi');
              }
              if (index == 2) {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            },
          ),
        );
      },
    );
  }
}
