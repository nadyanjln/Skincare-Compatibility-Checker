import 'package:capstone/ui/detail_product/detail_product_screen.dart';
import 'package:capstone/ui/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/provider/wishlist_provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

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
                  onAdd: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.name} added to lab 🧪"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xff007BFF),
                      ),
                    );
                  },
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
