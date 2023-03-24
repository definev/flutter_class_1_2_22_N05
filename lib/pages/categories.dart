import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';

class PriorityBox extends StatefulWidget {
  const PriorityBox({super.key});

  @override
  State<PriorityBox> createState() => _PriorityBoxState();
}

class _PriorityBoxState extends State<PriorityBox> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, null),
          icon: const Icon(LineIcons.backspace, color: Colors.black),
        ),
        title: const Text(
          "Ưu tiên",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(LineIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: TodoPriority.values.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Text(
                    TodoPriority.values[index].text,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context, TodoPriority.values[index]),
                    icon: const Icon(LineIcons.plus, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
