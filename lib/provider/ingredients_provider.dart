import 'package:flutter/material.dart';

class ProductIngredient {
  final String name;
  final String brand;
  final String image;
  final List<String> ingredients;

  ProductIngredient({
    required this.name,
    required this.brand,
    required this.image,
    this.ingredients = const [],
  });
}

class IngredientsProvider extends ChangeNotifier {
  final List<ProductIngredient> _products = [];
  final List<String> _manualIngredients = [];
  bool _isLoading = false;

  List<ProductIngredient> get products => List.unmodifiable(_products);
  List<String> get manualIngredients => List.unmodifiable(_manualIngredients);
  bool get isLoading => _isLoading;
  bool get hasIngredients =>
      _products.isNotEmpty || _manualIngredients.isNotEmpty;
  int get ingredientsCount => _products.length + _manualIngredients.length;

  // Add product from cart
  void addProduct(
    String name,
    String brand,
    String image, {
    List<String> ingredients = const [],
  }) {
    // Check if product already exists
    final existingIndex = _products.indexWhere(
      (p) => p.name == name && p.brand == brand,
    );

    if (existingIndex == -1) {
      _products.add(
        ProductIngredient(
          name: name,
          brand: brand,
          image: image,
          ingredients: ingredients,
        ),
      );
      notifyListeners();
    }
  }

  // Remove product by index
  void removeProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _products.removeAt(index);
      notifyListeners();
    }
  }

  // Manual ingredient methods (existing functionality)
  void addIngredient(String ingredient) {
    if (ingredient.trim().isNotEmpty) {
      _manualIngredients.add(ingredient.trim());
      notifyListeners();
    }
  }

  void addMultipleIngredients(List<String> newIngredients) {
    for (var ingredient in newIngredients) {
      if (ingredient.trim().isNotEmpty) {
        _manualIngredients.add(ingredient.trim());
      }
    }
    notifyListeners();
  }

  void removeManualIngredient(int index) {
    if (index >= 0 && index < _manualIngredients.length) {
      _manualIngredients.removeAt(index);
      notifyListeners();
    }
  }

  void clearAll() {
    _products.clear();
    _manualIngredients.clear();
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Get all ingredients combined
  List<String> getAllIngredients() {
    final allIngredients = <String>[];

    for (var product in _products) {
      allIngredients.addAll(product.ingredients);
    }

    allIngredients.addAll(_manualIngredients);

    return allIngredients;
  }
}
