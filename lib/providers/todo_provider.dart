import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  String currentDate = DateFormat.yMMMd().format(DateTime.now());

  //test data
  List<Todo> allTodos = [
    Todo(
      title: "Meet with Boss",
      date: DateTime.now(),
      time: "8:00 AM",
      description: "Approval for new project",
      priority: TodoPriority.urgent,
    ),
    Todo(
      title: "Pick up Joey from Basketball",
      date: DateTime.now(),
      time: "3:00 PM",
      description: "",
      priority: TodoPriority.important,
    ),
    Todo(
      title: "Breakfast Meeting",
      date: DateTime.now(),
      time: "9:30 AM",
      description: "With department heads",
      priority: TodoPriority.urgent,
    ),
    Todo(
      title: "Lunch at Zambino's with Greg",
      date: DateTime.now(),
      time: "12:00 PM",
      description: "To discuss Exodus presentation",
      priority: TodoPriority.normal,
    ),
  ];

  List<Todo> get deletedTodos {
    return allTodos.where((element) => element.toBeDeleted).toList();
  }

  List<Todo> get completedTodos {
    return allTodos.where((element) => element.isComplete && !element.toBeDeleted).toList();
  }

  void addTodo(String title, String description, DateTime? date, String time, TodoPriority priority) {
    allTodos.add(Todo(title: title, date: date, description: description, time: time, priority: priority));
    notifyListeners();
  }

  void toggleToBeDeleted(Todo todo) {
    todo.toBeDeleted = !todo.toBeDeleted;
    notifyListeners();
  }

  void toggleIsComplete(Todo todo) {
    todo.isComplete = !todo.isComplete;
    notifyListeners();
  }

  List<Todo> getSearchResults(String task) {
    return allTodos.where((element) => RegExp(task, caseSensitive: false).hasMatch(element.title)).toList();
  }
}
