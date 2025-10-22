import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedCategoryIndex = 0;

  // Getter
  int get selectedCategoryIndex => _selectedCategoryIndex;

  // Set selected category
  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  // Reset to default (optional)
  void resetCategory() {
    _selectedCategoryIndex = 0;
    notifyListeners();
  }
}
