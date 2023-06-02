import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class TaskList extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  Function(bool?)? onchange;

  TaskList({
    super.key,
    required this.taskName,
    required this.taskStatus,
    required this.onchange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
      color: Colors.teal[100],
      child: Row(
        children: [
          Checkbox(value: taskStatus, onChanged: onchange),
          Text(
            taskName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          // child: Row(
          // children: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          // ],
          // )

          Row(
            children: [
              IconButton(
                onPressed: () {
                  print("edit");
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  print("Delete");
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
