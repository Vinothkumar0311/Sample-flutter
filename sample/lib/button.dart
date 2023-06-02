import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: avoid_unnecessary_containers

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  var listSelect = ['Sample1', 'Sample2', 'Sample3', 'Sample4'];
  String? currentValue;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {},
                child: const Text('TextButton'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 90, right: 90, top: 12),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('ElevatedButton'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 90, right: 90, top: 12),
              child: OutlinedButton(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: 'Sample popUp message',
                    timeInSecForIosWeb: 0,
                    gravity: ToastGravity.CENTER,
                  );
                },
                child: const Text('Toast'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 35),
              child: DropdownButton(
                hint: const Text(
                  'Select',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: listSelect.map((String element) {
                  return DropdownMenuItem(
                    value: element,
                    child: Text(element),
                  );
                }).toList(),
                onChanged: (String? userSelctValue) {
                  setState(() {
                    currentValue = userSelctValue!;
                  });
                },
                value: currentValue,
              ),
            ),
            Image.asset('images/sample.jpeg')
          ],
        ),
      ),
    );
  }
}
