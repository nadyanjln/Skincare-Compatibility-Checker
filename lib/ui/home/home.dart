import 'package:capstone/ui/bottom_navbar.dart';
import 'package:capstone/provider/ingredients_provider.dart';
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

  int selectedIndex = 0;
  final Set<int> wishlist = {};

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
                '${product['name']} ditambahkan ke Lab',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff007BFF),
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
  }

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan kategori
    final filteredProducts = selectedIndex == 0
        ? products // semua produk kalau pilih "All"
        : products
              .where((p) => p['category'] == categories[selectedIndex]['label'])
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      // TODO: Add your camera action here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Camera clicked')),
                      );
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    final item = categories[index];
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: CategoryItem(
                        icon: item['icon'],
                        label: item['label'],
                        isSelected: index == selectedIndex,
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 30),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.55,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final isWishlisted = wishlist.contains(index);

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/product_detail',
                        arguments: product,
                      );
                    },
                    child: ProductCard(
                      image: product['image'],
                      name: product['name'],
                      brand: product['brand'],
                      isWishlisted: isWishlisted,
                      onWishlistToggle: () {
                        setState(() {
                          if (isWishlisted) {
                            wishlist.remove(index);
                          } else {
                            wishlist.add(index);
                          }
                        });
                      },
                      onAdd: () => _addToLab(context, product),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

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
  }
}
