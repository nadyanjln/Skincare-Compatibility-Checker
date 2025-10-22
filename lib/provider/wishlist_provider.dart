import 'package:flutter/material.dart';
import 'ingredients_provider.dart'; // import ProductIngredient

class WishlistProvider extends ChangeNotifier {
  final List<ProductIngredient> _wishlistProducts = [];

  // Getter: ambil semua produk wishlist
  List<ProductIngredient> get wishlistProducts =>
      List.unmodifiable(_wishlistProducts);

  // Mengecek apakah produk sudah ada di wishlist
  bool isInWishlist(String name, String brand) {
    return _wishlistProducts.any((p) => p.name == name && p.brand == brand);
  }

  // Tambah produk ke wishlist
  bool addToWishlist(ProductIngredient product) {
    if (!isInWishlist(product.name, product.brand)) {
      _wishlistProducts.add(product);
      notifyListeners();
      return true;
    }
    return false; // sudah ada
  }

  // Hapus produk dari wishlist
  bool removeFromWishlist(String name, String brand) {
    final index = _wishlistProducts.indexWhere(
      (p) => p.name == name && p.brand == brand,
    );
    if (index != -1) {
      _wishlistProducts.removeAt(index);
      notifyListeners();
      return true;
    }
    return false; // tidak ada
  }

  // Toggle wishlist (untuk tombol love)
  void toggleWishlist(ProductIngredient product) {
    if (isInWishlist(product.name, product.brand)) {
      removeFromWishlist(product.name, product.brand);
    } else {
      addToWishlist(product);
    }
  }

  // Clear semua wishlist
  void clearWishlist() {
    _wishlistProducts.clear();
    notifyListeners();
  }
}
