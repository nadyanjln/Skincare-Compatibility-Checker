import 'package:flutter/material.dart';

class FormValidationProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _termsAccepted = false;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get termsAccepted => _termsAccepted;

  // Validasi dasar
  bool get isNameValid => _name.trim().length >= 3;

  bool get isEmailValid {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(_email);
  }

  bool get isPasswordValid => _password.length >= 8;

  bool get doPasswordsMatch =>
      _password == _confirmPassword && _password.isNotEmpty;

  bool get isLoginFormValid => _email.isNotEmpty && _password.isNotEmpty;

  bool get isRegisterFormValid =>
      isNameValid &&
      isEmailValid &&
      isPasswordValid &&
      doPasswordsMatch &&
      _termsAccepted;

  bool get isResetFormValid =>
      isEmailValid && isPasswordValid && doPasswordsMatch;

  // Setters
  void setName(String value) {
    _name = value;
    notifyListeners();
  }

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
    _name = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    _termsAccepted = false;
    notifyListeners();
  }
}
