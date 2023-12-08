import 'dart:convert';

Folder usersFromMap(String str) => Folder.fromMap(json.decode(str));

String usersToMap(Folder data) => json.encode(data.toMap());

class Folder {
  final int? id;
  final int userId;
  final String name;
  final String? createdAt;

  Folder({
    this.id,
    required this.userId,
    required this.name,
    this.createdAt,
  });

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "name": name,
        "createdAt": createdAt,
      };
}
