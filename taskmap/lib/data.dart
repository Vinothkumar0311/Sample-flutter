import 'package:hive_flutter/hive_flutter.dart';

class TaskDataBase {
   List taskInput = [];
   List<Map<String, dynamic>> taskInputMap = [];
  final _taskBox = Hive.box('taskBox');
  // Run while the app started
  createFirstData() {
    taskInput = [];
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
