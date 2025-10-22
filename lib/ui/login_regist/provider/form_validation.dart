import 'package:flutter/material.dart';

class FormValidationProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _termsAccepted = false;

  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get termsAccepted => _termsAccepted;

  // Computed properties
  bool get isEmailValid {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(_email);
  }

  bool get isPasswordValid => _password.length >= 8;

  bool get doPasswordsMatch => 
      _password == _confirmPassword && _password.isNotEmpty;

  bool get isLoginFormValid => 
      _email.isNotEmpty && _password.isNotEmpty;

  bool get isRegisterFormValid =>
      isEmailValid && 
      isPasswordValid && 
      doPasswordsMatch && 
      _termsAccepted;

  bool get isResetFormValid =>
      isEmailValid && 
      isPasswordValid && 
      doPasswordsMatch;

  // Setters
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  void reset() {
    _email = '';
    _password = '';
    _confirmPassword = '';
    _termsAccepted = false;
    notifyListeners();
  }
}