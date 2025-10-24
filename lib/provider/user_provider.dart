import 'package:capstone/data/api/api_services.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  UserProvider(this._apiServices);

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

  // Login method
  Future<bool> login(String email, String password) async {
    try {
      final result = await _apiServices.login(email, password);

      // pre registered
      // user@gmail.com
      // password123
      if (result.user.email == email) {
        _email = result.user.email;
        _name = result.user.name;
        _userId = result.user.name;
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
      final result = await _apiServices.signup(email, name, password);

      _name = result.name;
      _email = result.email;
      _userId = result.id.toString();
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
      await _apiServices.changePassword(_userId!, newPassword);

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
