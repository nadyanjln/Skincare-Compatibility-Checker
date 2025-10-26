import 'package:capstone/provider/ingredients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultIngredientListWidget extends StatelessWidget {
  const ResultIngredientListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientsProvider>(
      builder: (context, provider, child) {
        if (!provider.hasIngredients) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.science_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'No products yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add products from the main page',
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
              ],
            ),
          );
        }

        return ListView(
          children: [
            // Product cards
            ...List.generate(provider.products.length, (index) {
              final product = provider.products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ProductCard(
                  product: product,
                  onDelete: () => provider.removeProduct(index),
                ),
              );
            }),

            // Manual ingredients (if any)
            if (provider.manualIngredients.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Kandungan Manual',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              ...List.generate(provider.manualIngredients.length, (index) {
                final ingredient = provider.manualIngredients[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _ManualIngredientCard(
                    ingredient: ingredient,
                    onDelete: () => provider.removeManualIngredient(index),
                  ),
                );
              }),
            ],
          ],
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductIngredient product;
  final VoidCallback onDelete;

  const _ProductCard({required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.brand,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManualIngredientCard extends StatelessWidget {
  final String ingredient;
  final VoidCallback onDelete;

  const _ManualIngredientCard({
    required this.ingredient,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.circle,
                size: 8,
                color: Color(0xff007BFF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                ingredient,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.close, color: Colors.black54, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
