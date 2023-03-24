import 'package:flutter/material.dart';

enum TodoPriority { urgent, important, normal }

extension TodoPriorityExt on TodoPriority {
  String get text {
    switch (this) {
      case TodoPriority.urgent:
        return 'Khẩn cấp';
      case TodoPriority.important:
        return 'Quan trọng';
      case TodoPriority.normal:
        return 'Bình thường';
    }
  }

  Widget widget(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: () {
            switch (this) {
              case TodoPriority.urgent:
                return Colors.red;
              case TodoPriority.important:
                return Colors.orange;
              case TodoPriority.normal:
                return Colors.green;
            }
          }(),
        ),
      );
}

class Todo {
  TodoPriority priority;
  String description = "";
  String title;
  DateTime? date;
  String time;
  bool isComplete = false;
  bool toBeDeleted = false;

  Todo({
    required this.title,
    required this.date,
    required this.description,
    required this.time,
    required this.priority,
  });
}
