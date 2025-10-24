// File: lib/provider/onboarding_provider.dart
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;

  void onPageChanged(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
