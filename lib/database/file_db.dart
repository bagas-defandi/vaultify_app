import 'package:sqflite/sqflite.dart';
import 'package:vaultify_app/database/database_service.dart';
import 'package:vaultify_app/model/file.dart';

class FileDB {
  final tableName = 'files';
  late String sqlQuery;

  FileDB() {
    sqlQuery = '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,    
        folderId INTEGER NOT NULL,    
        name TEXT NOT NULL,
        path TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
          ON DELETE CASCADE ON UPDATE CASCADE
        FOREIGN KEY (folderId) REFERENCES folders (id)
          ON DELETE CASCADE ON UPDATE CASCADE
      )''';
  }

  Future<void> createTable(Database database) async {
    await database.execute(sqlQuery);
  }

  Future<int> create(File file) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, file.toMap());
  }

  Future<List<File>> fetchUserFiles(int userId, int folderId) async {
    final db = await DatabaseService().database;
    List<Map<String, dynamic>> results = await db.query(tableName,
        where: "userId = ? AND folderId = ?", whereArgs: [userId, folderId]);

    List<File> files = [];
    results.forEach((result) {
      File file = File.fromMap(result);
      files.add(file);
    });
    return files;
  }

  Future<void> deleteFile(int id) async {
    final db = await DatabaseService().database;
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
