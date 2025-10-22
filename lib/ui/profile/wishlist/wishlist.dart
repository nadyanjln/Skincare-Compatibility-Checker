import 'package:capstone/ui/detail_product/detail_product_screen.dart';
import 'package:capstone/ui/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/provider/wishlist_provider.dart';
import 'package:capstone/provider/ingredients_provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  void _addToLab(BuildContext context, dynamic product) {
    final provider = context.read<IngredientsProvider>();

    // Tambahkan ke provider seperti di Home
    final added = provider.addProduct(
      product.name,
      product.brand,
      product.image,
      ingredients: product.ingredients,
    );

    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.science, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${product.name} has been added to the Lab',
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
    } else {
      // Kalau sudah ada di Lab
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${product.name} is already in the Lab',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        backgroundColor: const Color(0xff007BFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          final wishlist = wishlistProvider.wishlistProducts;

          if (wishlist.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Your wishlist is empty 💔\nAdd your favorite items to see them here!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final product = wishlist[index];

                return ProductCard(
                  image: product.image,
                  name: product.name,
                  brand: product.brand,
                  isWishlisted: wishlistProvider.isInWishlist(
                    product.name,
                    product.brand,
                  ),
                  onWishlistToggle: () {
                    wishlistProvider.toggleWishlist(product);
                  },
                  // ✅ Sama seperti di Home
                  onAdd: () => _addToLab(context, product),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductDetailPage(),
                        settings: RouteSettings(
                          arguments: {
                            'image': product.image,
                            'name': product.name,
                            'brand': product.brand,
                            'ingredients': product.ingredients,
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
