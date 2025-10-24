import 'dart:convert';

class UserResponse {
  final User user;
  final String token;

  UserResponse({
    required this.user,
    required this.token,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse.fromMap(json);

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
    user: User.fromMap(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "user": user.toMap(),
    "token": token,
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User.fromMap(json);

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
