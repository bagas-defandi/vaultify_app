import 'package:sqflite/sqflite.dart';
import 'package:vaultify_app/database/database_service.dart';
import 'package:vaultify_app/model/folder.dart';

class FolderDB {
  final tableName = 'folders';
  late String sqlQuery;

  FolderDB() {
    sqlQuery = '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,    
        name TEXT NOT NULL,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP,  
        FOREIGN KEY (userId) REFERENCES users (id)                  
          ON DELETE CASCADE ON UPDATE CASCADE
      )''';
  }

  Future<void> createTable(Database database) async {
    await database.execute(sqlQuery);
  }

  Future<int> create(Folder folder) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, folder.toMap());
  }

  Future<List<Folder>> fetchUserFolders(int userId) async {
    final db = await DatabaseService().database;
    List<Map<String, dynamic>> results =
        await db.query(tableName, where: "userId = ?", whereArgs: [userId]);

    List<Folder> folders = [];
    results.forEach((result) {
      Folder folder = Folder.fromMap(result);
      folders.add(folder);
    });
    return folders;
  }

  Future<void> deleteFolder(int id) async {
    final db = await DatabaseService().database;
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateFolder(name, id) async {
    // Get a reference to the database.
    final db = await DatabaseService().database;

    await db.update(tableName, {'name': name},
        where: 'id = ?', whereArgs: [id]);
  }
}
