import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final String text;
  final int todoId;
  final Future<void> Function(int) delete;
  const TodoCard({
    required this.delete,
    required this.text,
    required this.todoId,
    super.key,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      key: UniqueKey(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontSize: 20),
          ),
          Container(
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await widget.delete(widget.todoId);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
