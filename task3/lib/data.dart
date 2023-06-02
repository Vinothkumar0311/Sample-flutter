import 'map_value.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskDataBase {
  List<dynamic> taskInput = [];
  List<Map<String, dynamic>> taskMap = [];
  List<dynamic> conMap = [];
  final _taskBox = Hive.box('taskBox');
  // Run while the app started
  createFirstData() {
    taskInput = [];
  }

  // Load data from local
  loadData() {
    taskInput = _taskBox.get("TASKINPUT");
    // taskMap = _taskBox.get("TASKINPUT");
  }

  // Update the data
  void updateData() {
    _taskBox.put("TASKINPUT", taskInput);
    // _taskBox.put("TASKINPUT", taskMap);
  }

  createFirstDataMap() {
    taskMap = [];
  }

  loadDataMap() {
    taskMap = _taskBox.get("TASKMAP");
  }

  void updateDataMap() {
    _taskBox.put("TASKMAP", taskMap);
  }
}
