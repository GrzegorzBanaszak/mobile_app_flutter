import 'package:mobile_app/db/todo_db.dart';
import 'package:mobile_app/db/user_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    const name = 'users2.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: create,
      onUpgrade: upgrade,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await UserDB().createTable(database);
    await TodoDB().createTable(database);
  }

  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await UserDB().createTable(db);
      await TodoDB().createTable(db);
    }
  }
}
