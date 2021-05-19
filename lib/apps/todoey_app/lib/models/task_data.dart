import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'task.dart';

class TaskData with ChangeNotifier {
  List<Task> _task = [
    Task(name: 'Buy a Mobile'),
    Task(name: 'Buy a Laptop'),
    Task(name: 'Buy a Tab'),
    Task(name: 'Buy a ipod'),
    Task(name: 'Buy a Mobile'),
  ];

  UnmodifiableListView<Task> get task {
    return UnmodifiableListView(_task);
  }

  int get dataCount {
    return _task.length;
  }

  void addNewTask(String value) {
    final datas = Task(name: value);
    _task.add(datas);
    notifyListeners();
  }

  void updateTask(Task tasks) {
    tasks.toggleButton();

    notifyListeners();
  }

  void deleteTask(Task tasks) {
    _task.remove(task);

    notifyListeners();
  }
}
