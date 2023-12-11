import 'dart:convert';

File usersFromMap(String str) => File.fromMap(json.decode(str));

String usersToMap(File data) => json.encode(data.toMap());

class File {
  final int? id;
  final int userId;
  final int folderId;
  final String name;
  final String path;

  File({
    this.id,
    required this.userId,
    required this.folderId,
    required this.name,
    required this.path,
  });

  factory File.fromMap(Map<String, dynamic> json) => File(
        id: json["id"],
        userId: json["userId"],
        folderId: json["folderId"],
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "folderId": folderId,
        "name": name,
        "path": path,
      };
}
