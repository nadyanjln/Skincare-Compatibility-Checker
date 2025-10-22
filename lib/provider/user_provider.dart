import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // Data user
  String? _name;
  String? _email;
  String? _userId;
  bool _isLoggedIn = false;

  // Getters
  String? get name => _name;
  String? get email => _email;
  String? get userId => _userId;
  bool get isLoggedIn => _isLoggedIn;

  // Dummy credentials untuk validasi login demo
  final String _dummyEmail = "user@gmail.com";
  final String _dummyPassword = "password123";

  // Login method
  Future<bool> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (email == _dummyEmail && password == _dummyPassword) {
        _email = email;
        _name = "User Demo";
        _userId = "user_${DateTime.now().millisecondsSinceEpoch}";
        _isLoggedIn = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Login error: $e");
      return false;
    }
  }

  // Register method
  Future<bool> register(String name, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      _name = name;
      _email = email;
      _userId = "user_${DateTime.now().millisecondsSinceEpoch}";
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Register error: $e");
      return false;
    }
  }

  // Reset password
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      debugPrint("Reset password error: $e");
      return false;
    }
  }

  // Logout
  void logout() {
    _name = null;
    _email = null;
    _userId = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Update nama user
  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  // Update email user
  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  // Cek autentikasi
  bool isAuthenticated() {
    return _isLoggedIn && _email != null;
  }
}
