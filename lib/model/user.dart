import 'dart:convert';

User usersFromMap(String str) => User.fromMap(json.decode(str));

String usersToMap(User data) => json.encode(data.toMap());

class User {
  final int? id;
  final String? name;
  final String username;
  final String password;

  User({
    this.id,
    this.name,
    required this.username,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "password": password,
      };
}
