import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  String currentDate = DateFormat.yMMMd().format(DateTime.now());

  //test data
  List<Todo> allTodos = [
    Todo(
      title: "Đi chợ",
      date: DateTime.now(),
      time: "8:00 Sáng",
      description: "Mua thực phẩm cho cả tuần",
      priority: TodoPriority.important,
    ),
    Todo(
      title: "Tập thể dục",
      date: DateTime.now(),
      time: "6:00 Chiều",
      description: "Chạy bộ hoặc tập thể dục thể thao",
      priority: TodoPriority.normal,
    ),
    Todo(
      title: "Học tập",
      date: DateTime.now(),
      time: "7:00 Tối",
      description: "Ôn tập kiến thức, làm bài tập, đọc sách",
      priority: TodoPriority.urgent,
    ),
    Todo(
      title: "Gọi điện",
      date: DateTime.now(),
      time: "10:00 Sáng",
      description: "Liên lạc với khách hàng để bàn giao sản phẩm",
      priority: TodoPriority.normal,
    ),
    Todo(
      title: "Viết blog",
      date: DateTime.now(),
      time: "",
      description: "Viết bài blog về chủ đề kinh doanh",
      priority: TodoPriority.urgent,
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
    return extractAllSorted<Todo>(
      query: task,
      choices: allTodos,
      getter: (obj) => obj.title,
    ).fold([], (previousValue, element) {
      if (element.score > 50) {
        return previousValue..add(element.choice);
      }
      return previousValue;
    });
  }
}
