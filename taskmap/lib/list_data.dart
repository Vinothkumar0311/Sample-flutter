import 'data.dart';
import 'listvalue_table.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var textChangeEdit = TextEditingController();
  late int editTextIndex;
  bool isEditing = false;

  // Getting value from database
  final _taskBox = Hive.box('taskBox');
  TaskDataBase localDB = TaskDataBase();

  @override
  void initState() {
    if (_taskBox.get("TASKINPUT") == null) {
      localDB.createFirstData();
    } else {
      localDB.loadData();
    }
    // _foundToDo = localDB.taskInput;
    super.initState();
  }

  void _filterTodo(String searchValue) {
    List<dynamic> searchResult = [];
    if (searchValue.isEmpty) {
      searchResult = localDB.taskInput;
    } else {
      searchResult = localDB.taskInput
          .where(
              (item) => item.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    }
    setState(() {
      localDB.taskInput = searchResult;
    });
  }

  void editTextCall(index) {
    setState(() {
      textChangeEdit.text = localDB.taskInput[index];
      isEditing = true;
      editTextIndex = index;
    });
    print(localDB.taskInput.asMap());
  }

  void updateValue() {
    setState(() {
      localDB.taskInput[editTextIndex] = textChangeEdit.text;
      isEditing = false;
      Navigator.of(context).pop();
      textChangeEdit.text = '';
    });
    localDB.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListData'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Box
          searchBox(),
          Expanded(
            // Showing the task using editTextIndexlist View
            child: ListView.builder(
              itemCount: localDB.taskInput.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  color: Colors.teal[100],
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 25)),
                      Text(
                        localDB.taskInput[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Changing the task name
                              showPopUp();
                              editTextCall(index);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              //remove the item at the current index
                              setState(() {
                                localDB.taskInput.removeAt(index);
                              });
                              localDB.updateData();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return const AllValueOrder();
          }));
        },
        child: const Icon(Icons.table_chart),
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

  showPopUp() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Card(
            color: Colors.transparent,
            child: TextField(
              controller: textChangeEdit,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  updateValue();
                },
                child: const Text('Update')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        ),
      );
}
