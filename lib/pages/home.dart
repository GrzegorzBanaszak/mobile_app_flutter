import 'package:flutter/material.dart';
import 'package:mobile_app/components/circle.dart';
import 'package:mobile_app/components/todo_card.dart';
import 'package:mobile_app/db/todo_db.dart';
import 'package:mobile_app/db/user_db.dart';
import 'package:mobile_app/models/todo.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/pages/add_todo.dart';
import 'package:mobile_app/pages/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user;
  String test = 'Hello';
  List<Todo> todos = List.empty();

  @override
  void initState() {
    super.initState();
    _getUser();
    getTodos();
  }

  Future<void> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final db = UserDB();
    User item = await db.getById(prefs.getInt('userId')!);

    setState(() {
      user = item;
    });
  }

  Future<void> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final db = TodoDB();
    final items = await db.getTodosByUserId(prefs.getInt('userId')!);

    setState(() {
      todos = items;
    });
  }

  Future<void> deleteTodo(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final db = TodoDB();
    await db.delete(id);

    final items = await db.getTodosByUserId(user!.id);

    setState(() {
      todos = items;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", false);
    await prefs.setInt("userId", 0);

    Navigator.pop(context);
    await Navigator.push(
      // ignore: inference_failure_on_instance_creation
      context, MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) => AddTodo(
                  updateList: getTodos,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              const Positioned(
                top: -150,
                left: -20,
                child: Circle(
                  color: '#BB84E8',
                  size: 250,
                ),
              ),
              const Positioned(
                top: -120,
                right: -120,
                child: Circle(
                  color: '#471AA0',
                  size: 300,
                ),
              ),
              const Positioned(
                bottom: -170,
                left: -50,
                child: Circle(
                  color: '#471AA0',
                  size: 320,
                ),
              ),
              const Positioned(
                bottom: -180,
                right: -70,
                child: Circle(
                  color: '#BB84E8',
                  size: 250,
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.only(top: 90),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final item = todos[index];
                  return TodoCard(
                    delete: deleteTodo,
                    text: item.todoText,
                    todoId: item.id,
                  );
                },
              ),
              Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Welcom ${user?.fullName ?? ''}"),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: logout,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
