import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vaultify_app/database/folder_db.dart';
import 'package:vaultify_app/database/user_db.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'vaultify.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await UserDB().createTable(database);
    await FolderDB().createTable(database);
  }
}
