import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // User data
  String? _email;
  String? _userId;
  bool _isLoggedIn = false;

  // Getters
  String? get email => _email;
  String? get userId => _userId;
  bool get isLoggedIn => _isLoggedIn;

  // Dummy credentials untuk validasi
  final String _dummyEmail = "user@gmail.com";
  final String _dummyPassword = "password123";

  // Login method
  Future<bool> login(String email, String password) async {
    try {
      // Simulasi API call
      await Future.delayed(const Duration(seconds: 1));

      // Validasi credentials
      if (email == _dummyEmail && password == _dummyPassword) {
        _email = email;
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
  Future<bool> register(String email, String password) async {
    try {
      // Simulasi API call
      await Future.delayed(const Duration(seconds: 1));

      // Simpan data user
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

  // Reset password method
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      // Simulasi API call
      await Future.delayed(const Duration(seconds: 1));

      // Dalam aplikasi real, ini akan mengirim request ke backend
      // Untuk demo, kita anggap berhasil
      return true;
    } catch (e) {
      debugPrint("Reset password error: $e");
      return false;
    }
  }

  // Logout method
  void logout() {
    _email = null;
    _userId = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Update user profile
  void updateProfile(String email) {
    _email = email;
    notifyListeners();
  }

  // Check if user is authenticated
  bool isAuthenticated() {
    return _isLoggedIn && _email != null;
  }
}
