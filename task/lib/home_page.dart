import 'data.dart';
import 'input_field.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore_for_file: unused_element

class Viewdata extends StatefulWidget {
  const Viewdata({super.key});
  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  // Hive
  final _taskBox = Hive.box('taskBox');
  TaskDataBase db = TaskDataBase();

  final _controller = TextEditingController();
  // List<dynamic> taskInput = ["Task1", "Task2"];
  List _foundToDo = [];
  late int editTextCalled;
  bool isEditing = false;
  @override
  void initState() {
    if (_taskBox.get("TASKINPUT") == null) {
      db.createFirstData();
    } else {
      db.loadData();
    }
    _foundToDo = db.taskInput;
    super.initState();
  }

  void saveTaskList() {
    // Checking the value is duplicate or not
    if (db.taskInput.contains(_controller.text)) {
      Fluttertoast.showToast(
        msg: 'Value already entered',
        gravity: ToastGravity.CENTER,
        fontSize: 25,
        backgroundColor: Colors.red,
      );const Placeholder();
      if (_controller.text.trim().isNotEmpty) {
        // if the task will be edit
        if (isEditing == true) {
          updateTask();
        } else {
          setState(() {
            db.taskInput.add(_controller.text);
            _controller.text = '';
            Navigator.of(context).pop();
          });
          db.updateData();
        }
      }
      // Checking the input is empty or not
      else {
        Fluttertoast.showToast(
          msg: 'Field is Empty',
          gravity: ToastGravity.CENTER,
          fontSize: 25,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  // Update the value after edit function is called
  updateTask() {
    setState(() {
      db.taskInput[editTextCalled] = _controller.text;
      isEditing = false;
      Navigator.of(context).pop();
      _controller.text = '';
    });
    db.updateData();
  }

  // Calling the input field
  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return InputField(
          controller: _controller,
          saveInput: saveTaskList,
          closeField: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Search the task filter by using input value
  void _filterTodo(String searchValue) {
    List<dynamic> searchResult = [];
    if (searchValue.isEmpty) {
      searchResult = db.taskInput;
    } else {
      searchResult = db.taskInput
          .where(
              (item) => item.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = searchResult;
    });
  }

  // Edit function
  void editText(index) {
    setState(() {
      _controller.text = db.taskInput[index];
      isEditing = true;
      editTextCalled = index;
    });
  }

  // Removing the task for list
  void _deleteToDoItem(int id) {
    setState(() {
      db.taskInput.removeWhere((item) => item.id == id);
      db.updateData();
    });
    // db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Data List'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Search Box
            searchBox(),
            Expanded(
              // Showing the task using list View
              child: ListView.builder(
                itemCount: _foundToDo.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    color: Colors.teal[100],
                    child: Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 25)),
                        Text(
                          _foundToDo[index],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Changing the task name
                                editText(index);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                //remove the item at the current index
                                setState(() {
                                  db.taskInput.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        // Button to add new task
        floatingActionButton: FloatingActionButton(
          onPressed: addNewTask,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Search field
  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 45, right: 45),
      child: TextField(
        onChanged: (value) => _filterTodo(value),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
