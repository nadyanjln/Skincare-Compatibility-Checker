import 'dart:convert';

class Product {
  final String name;
  final String brand;
  final String category;
  final String keyIngredients;
  final String allIngredients;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Product({
    required this.name,
    required this.brand,
    required this.category,
    required this.keyIngredients,
    required this.allIngredients,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    name: json["name"],
    brand: json["brand"],
    category: json["category"],
    keyIngredients: json["keyIngredients"],
    allIngredients: json["allIngredients"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "brand": brand,
    "category": category,
    "keyIngredients": keyIngredients,
    "allIngredients": allIngredients,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
