import 'dart:convert';

import 'package:capstone/data/model/product_response.dart';
import 'package:capstone/data/model/user_response.dart';

import 'package:http/http.dart' as http;


class ApiServices {
  static const String _backendUrl = "http://103.147.159.137:8080/api";

  Future<UserResponse> login(String email, String password) async {
    final response = await http.post(
        Uri.parse("$_backendUrl/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        })
    );

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }

  Future<User> signup(String email, String name, String password) async {
    final response = await http.post(
        Uri.parse("$_backendUrl/users"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
        })
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Signup failed');
    }
  }

  Future<User> changeName(String id, String name) async {
    final response = await http.put(
        Uri.parse("$_backendUrl/users/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
        })
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed Change Name');
    }
  }

  Future<User> changeEmail(String id, String email) async {
    final response = await http.put(
        Uri.parse("$_backendUrl/users/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        })
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed Change Email');
    }
  }

  Future<User> changePassword(String id, String password) async {
    final response = await http.put(
        Uri.parse("$_backendUrl/users/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'password': password,
        })
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed Change Password');
    }
  }

  Future<Product> getProductList() async {
    final response = await http.get(Uri.parse("$_backendUrl/products"));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed Load Product List');
    }
  }
}