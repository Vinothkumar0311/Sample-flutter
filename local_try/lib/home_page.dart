import 'list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: avoid_print
// ignore_for_file: unused_import
// ignore_for_file: depend_on_referenced_packages

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController nameController = TextEditingController();

  List form = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 43, 197, 123),
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 85, left: 50, right: 50),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  hintText: 'Enter task to add',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  nameController.text = '';
                  if (name.isNotEmpty) {
                    form.add(name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contex) => const Viewdata(),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Field is Empty',
                        gravity: ToastGravity.CENTER,
                        fontSize: 25,
                        backgroundColor: Colors.red);
                  }

                  print(form);
                },
                child: const Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
