import 'package:mobile_app/db/database_service.dart';
import 'package:mobile_app/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDB {
  final tableName = 'flutterUsers';

  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS $tableName(
      "id" INTEGER NOT NULL,
      "fullName" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      UNIQUE(email)
    );''');
  }

  Future<int> create({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final database = await DatabaseService().database;

    return await database.rawInsert(
      'INSERT INTO $tableName (fullName,email,password) VALUES (?,?,?)',
      [fullName, email, password],
    );
  }

  Future<User> getById(int id) async {
    final database = await DatabaseService().database;
    final user = await database.rawQuery(
      '''
    SELECT id, email, fullName from $tableName WHERE id = ? 
''',
      [id],
    );

    return User.fromSqliteDatabase(user.first);
  }

  Future<int?> login({
    required String loginValue,
    required String password,
  }) async {
    final db = await DatabaseService().database;

    try {
      final user = await db.query(
        tableName,
        where: 'email = ? AND password = ?',
        whereArgs: [loginValue, password],
      );

      return int.parse(user.first['id'].toString());
    } catch (e) {
      return null;
    }
  }
}
