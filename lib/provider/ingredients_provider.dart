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

  // Untuk perbandingan dan debugging
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductIngredient &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          brand == other.brand;

  @override
  int get hashCode => name.hashCode ^ brand.hashCode;
}

class IngredientsProvider extends ChangeNotifier {
  final List<ProductIngredient> _products = [];
  final List<String> _manualIngredients = [];
  bool _isLoading = false;

  // Getters
  List<ProductIngredient> get products => List.unmodifiable(_products);
  List<String> get manualIngredients => List.unmodifiable(_manualIngredients);
  bool get isLoading => _isLoading;
  bool get hasIngredients =>
      _products.isNotEmpty || _manualIngredients.isNotEmpty;
  int get ingredientsCount => _products.length + _manualIngredients.length;

  // Product management methods

  /// Add product from product detail page
  /// Returns true if product was added, false if it already exists
  bool addProduct(
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
          ingredients: List<String>.from(ingredients), // Create a copy
        ),
      );
      notifyListeners();
      return true;
    }
    return false; // Product already exists
  }

  /// Remove product by index
  void removeProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _products.removeAt(index);
      notifyListeners();
    }
  }

  /// Remove product by name and brand
  bool removeProductByDetails(String name, String brand) {
    final index = _products.indexWhere(
      (p) => p.name == name && p.brand == brand,
    );

    if (index != -1) {
      _products.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Check if a product already exists in the lab
  bool hasProduct(String name, String brand) {
    return _products.any((p) => p.name == name && p.brand == brand);
  }

  // Manual ingredient management methods

  /// Add a single manual ingredient
  void addIngredient(String ingredient) {
    final trimmed = ingredient.trim();
    if (trimmed.isNotEmpty && !_manualIngredients.contains(trimmed)) {
      _manualIngredients.add(trimmed);
      notifyListeners();
    }
  }

  /// Add multiple manual ingredients at once
  void addMultipleIngredients(List<String> newIngredients) {
    bool hasChanges = false;

    for (var ingredient in newIngredients) {
      final trimmed = ingredient.trim();
      if (trimmed.isNotEmpty && !_manualIngredients.contains(trimmed)) {
        _manualIngredients.add(trimmed);
        hasChanges = true;
      }
    }

    if (hasChanges) {
      notifyListeners();
    }
  }

  /// Remove manual ingredient by index
  void removeManualIngredient(int index) {
    if (index >= 0 && index < _manualIngredients.length) {
      _manualIngredients.removeAt(index);
      notifyListeners();
    }
  }

  /// Remove manual ingredient by name
  bool removeManualIngredientByName(String ingredient) {
    final removed = _manualIngredients.remove(ingredient.trim());
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

  // Bulk operations

  /// Clear all products and manual ingredients
  void clearAll() {
    _products.clear();
    _manualIngredients.clear();
    notifyListeners();
  }

  /// Clear only products
  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  /// Clear only manual ingredients
  void clearManualIngredients() {
    _manualIngredients.clear();
    notifyListeners();
  }

  // Loading state

  /// Set loading state (for API calls or processing)
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Utility methods

  /// Get all ingredients combined from products and manual entries
  List<String> getAllIngredients() {
    final allIngredients = <String>[];

    // Add ingredients from all products
    for (var product in _products) {
      allIngredients.addAll(product.ingredients);
    }

    // Add manual ingredients
    allIngredients.addAll(_manualIngredients);

    return allIngredients;
  }

  /// Get unique ingredients (removing duplicates)
  List<String> getUniqueIngredients() {
    final allIngredients = getAllIngredients();
    return allIngredients.toSet().toList();
  }

  /// Get total number of ingredients (with duplicates)
  int getTotalIngredientsCount() {
    return getAllIngredients().length;
  }

  /// Get product count only
  int get productCount => _products.length;

  /// Get manual ingredients count only
  int get manualIngredientsCount => _manualIngredients.length;
}
