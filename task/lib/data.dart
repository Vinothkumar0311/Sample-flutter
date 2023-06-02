import 'package:hive_flutter/hive_flutter.dart';

class TaskDataBase {
  List taskInput = [];
  final _taskBox = Hive.box('taskBox');
  // Run while the app started
  createFirstData() {
    taskInput = ["Task1", "Task2"];
  }

  // Load data from local
  loadData() {
    taskInput = _taskBox.get("TASKINPUT");
  }

  // Update the data
  void updateData() {
    _taskBox.put("TASKINPUT", taskInput);
  }
}
