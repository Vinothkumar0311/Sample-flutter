import 'data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AllValueOrder extends StatefulWidget {
  const AllValueOrder({super.key});

  @override
  State<AllValueOrder> createState() => _AllValueOrderState();
}

class _AllValueOrderState extends State<AllValueOrder> {
  // Getting value from database
  final _taskBox = Hive.box('taskBox');
  TaskDataBase localDB = TaskDataBase();

  Map conveTaskInput = {};
  @override
  void initState() {
    if (_taskBox.get("TASKMAP") == null) {
      localDB.createFirstDataMap();
    } else {
      localDB.loadDataMap();
    }
    super.initState();
    print(localDB.taskMap.length);
    print(localDB.taskMap);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.only(top: 25),
          child: DataTable(
            horizontalMargin: 15,
            columnSpacing: 30,
            border: TableBorder.all(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Input1')),
              DataColumn(label: Text('Input2')),
              DataColumn(label: Text('Input3')),
              DataColumn(label: Text('Input4')),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('0')),
                DataCell(Text('value1')),
                DataCell(Text('value2')),
                DataCell(Text('value3')),
                DataCell(Text('value4'))
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('value4')),
                DataCell(Text('value5')),
                DataCell(Text('value6')),
                DataCell(Text('value7'))
              ]),
              DataRow(cells: [
                DataCell(Text('2')),
                DataCell(Text('value8')),
                DataCell(Text('value9')),
                DataCell(Text('value10')),
                DataCell(Text('value11'))
              ]),
              DataRow(cells: [
                DataCell(Text('3')),
                DataCell(Text('value12')),
                DataCell(Text('value13')),
                DataCell(Text('value14')),
                DataCell(Text('value15'))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
