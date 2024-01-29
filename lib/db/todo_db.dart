import 'package:mobile_app/db/database_service.dart';
import 'package:mobile_app/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDB {
  final tableName = 'usersTodos';

  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS $tableName(
      "id" INTEGER NOT NULL,
      "userId" INTEGER NOT NULL,
      "todoText" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY(userId) REFERENCES flutterUsers(id)
    );''');
  }

  Future<List<Todo>> getTodosByUserId(int id) async {
    final database = await DatabaseService().database;

    final List<Map<String, dynamic>> todosList =
        await database.query(tableName, where: 'userId = ?', whereArgs: [id]);

    return List.generate(todosList.length, (index) {
      return Todo(
        id: int.parse(todosList[index]['id'].toString()),
        userId: int.parse(todosList[index]['userId'].toString()),
        todoText: todosList[index]['todoText'].toString(),
      );
    });
  }

  Future<int> create(int userId, String todoText) async {
    final database = await DatabaseService().database;

    return database.insert(tableName, {'userId': userId, 'todoText': todoText});
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;

    await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
