import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/todo_property_row.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/categories.dart';
import 'package:todo_app/providers/todo_provider.dart';

class AddTaskModalBottomSheet extends StatefulWidget {
  const AddTaskModalBottomSheet({super.key});

  @override
  State<AddTaskModalBottomSheet> createState() => _AddTaskModalBottomSheetState();
}

class _AddTaskModalBottomSheetState extends State<AddTaskModalBottomSheet> {
  DateTime? date;
  String time = "";
  TodoPriority priority = TodoPriority.normal;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    ThemeData themeData = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 40, left: 40),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Tiêu đề",
            ),
            style: const TextStyle(fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Mô tả"),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => const PriorityBox(),
                    ))
                        .then((value) {
                      if (value == null) return;
                      setState(() {
                        priority = value;
                      });
                    });
                  },
                  icon: const Icon(LineIcons.tag),
                ),
                IconButton(
                  onPressed: () async {
                    await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2033),
                        builder: (context, child) => Theme(data: themeData, child: child!)).then((selectedDate) {
                      if (selectedDate != null) {
                        setState(() {
                          date = selectedDate;
                        });
                      }
                    });
                  },
                  icon: const Icon(LineIcons.calendar),
                ),
                IconButton(
                  onPressed: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) => Theme(data: themeData, child: child!),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        setState(() {
                          time = selectedTime.format(context);
                        });
                      }
                    });
                  },
                  icon: const Icon(LineIcons.clock),
                ),
                TodoPropertyRow(
                    property: time,
                    onDelete: () {
                      setState(() {
                        time = "";
                      });
                    }),
              ]),
              IconButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    provider.addTodo(
                        titleController.text.trim(), descriptionController.text.trim(), date, time, priority);
                  }
                  Navigator.of(context).pop();
                },
                icon: const Icon(LineIcons.paperPlane),
              )
            ],
          ),
        ],
      ),
    );
  }
}
