import 'inputfield_button.dart';
import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class InputField extends StatefulWidget {
  TextEditingController controller;
  VoidCallback saveInput;
  VoidCallback closeField;
  InputField({
    super.key,
    required this.controller,
    required this.saveInput,
    required this.closeField,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  var listSelect = ['Sample1', 'Sample2', 'Sample3', 'Sample4'];

  String? currentValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 55, left: 50, right: 50),
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelText: 'Task',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                hintStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                hintText: 'Enter task to add',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: DropdownButton(
              hint: const Text(
                'Select Your Preference',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: listSelect.map((String element) {
                // print(element);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(text: "Save", onPressed: widget.saveInput),
              const SizedBox(width: 8),
              MyButton(text: "Cancel", onPressed: widget.closeField),
              const SizedBox(width: 50),
            ],
          ),
        ],
      ),
    );
  }
}
