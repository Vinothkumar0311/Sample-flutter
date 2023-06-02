import 'package:http/http.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// import 'dart:html';

class XmlDemoFunction extends StatefulWidget {
  const XmlDemoFunction({super.key});

  @override
  State<XmlDemoFunction> createState() => _XmlDemoFunctionState();
}

class _XmlDemoFunctionState extends State<XmlDemoFunction> {
  @override
  void initState() {
    _xmlData();
    super.initState();
  }

  List dataValue = [];

  void _xmlData() async {
    print('xml called');
    final dataList = [];
    const studentXml = '''<?xml version="1.0"?>
  <students>
    <student>
      <studentName>Yash</studentName>
      <attendance>95</attendance>
    </student>
     <student>
      <studentName>Aditya</studentName>
      <attendance>80</attendance>
    </student>
    <student>
      <studentName>Rakhi</studentName>
      <attendance>85</attendance>
    </student>
    <student>
      <studentName>Mohit</studentName>
      <attendance>75</attendance>
    </student>
    <student>
      <studentName>Shaiq</studentName>
      <attendance>70</attendance>
    </student>
    <student>
      <studentName>Pragati</studentName>
      <attendance>65</attendance>
    </student>
  </students>''';
    print('sample check');
    final value = xml.XmlDocument.parse(studentXml);
    final student = value.findElements('students').first;
    final studentValue = student.findElements('student');
    for (final student in studentValue) {
      final studentName = student.findElements('studentName').first.innerText;
      final attendance = student.findElements('attendance').first.innerText;
      dataList.add({
        'studentName': studentName,
        'attendance': attendance,
      });
      print(dataList.toString());
    }
    setState(() {
      print('setstate');
      dataValue = dataList;
      print(dataList.toString());
    });
  }

  deleteValue(index) {
    setState(() {
      dataValue.removeAt(index);
    });
  }

  // editValue() {

  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Card(
              color: const Color.fromARGB(255, 93, 0, 255),
              elevation: 10,
              child: TextButton(
                  onPressed: () {
                    _xmlData();
                    setState(() {});
                  },
                  child: const Text(
                    'Load Data',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: dataValue.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StudentName : ${dataValue[index]['studentName']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Attendance : ${dataValue[index]['attendance']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            editValue();
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            deleteValue(dataValue.indexOf(dataValue[index]));
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              );
            },
          )),
        ],
      ),
    ));
  }

  Future editValue() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Update task'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextFormField(
                  // controller: commentsTitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    prefixIcon: Icon(
                      Icons.update,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: commentsPostidController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    prefixIcon: Icon(
                      Icons.update,
                      color: Colors.grey,
                    ),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // update(checkPopup, id, index);
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, 'cancel');
              },
              child: const Text('Cancel'),
            )
          ],
        ),
      );
}
