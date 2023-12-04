import 'package:sqflite/sqflite.dart';
import 'package:vaultify_app/database/database_service.dart';
import 'package:vaultify_app/model/user.dart';

class UserDB {
  final tableName = 'users';

  Future<void> createTable(Database database) async {
    await database.execute(
        "CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, username TEXT UNIQUE, password TEXT)");
  }

  // Method untuk login
  Future<bool> authenticate(User user) async {
    final db = await DatabaseService().database;
    var res = await db.rawQuery(
        "select * from $tableName where username = '${user.username}' AND password ='${user.password}' ");
    if (res.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // Method untuk signup yaitu membuat user
  Future<int> createUser(User user) async {
    final db = await DatabaseService().database;
    return db.insert(tableName, user.toMap());
  }

  // method untuk mendapatkan user yang sudah login
  Future<User?> getUser(String username) async {
    final db = await DatabaseService().database;
    var res =
        await db.query(tableName, where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  // method untuk cek apakah user sudah ada atau belum
  Future<bool> checkUserExist(String username) async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> res =
        await db.query(tableName, where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty;
  }
}
