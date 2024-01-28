class Todo {
  final int id;
  final int userId;
  final String todoText;

  Todo({required this.id, required this.userId, required this.todoText});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'todoText': todoText,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, userId: $userId, todoText: $todoText}';
  }

  factory Todo.fromSqliteDatabase(Map<String, dynamic> map) => Todo(
        id: int.parse(map['id'].toString()),
        userId: int.parse(map['userId'].toString()),
        todoText: map['todoText'].toString(),
      );
}
