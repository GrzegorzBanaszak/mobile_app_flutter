import 'package:flutter/material.dart';
import 'package:mobile_app/components/circle.dart';
import 'package:mobile_app/db/todo_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodo extends StatefulWidget {
  final Future<void> Function() updateList;
  const AddTodo({required this.updateList, super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  Future<void> addTodo() async {
    final db = TodoDB();
    final prefs = await SharedPreferences.getInstance();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Processing Data',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue[900],
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();

    await db.create(prefs.getInt('userId')!, textController.text);

    await widget.updateList();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Add todo',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: addTodo,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.blue[700],
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
