import 'package:flutter/material.dart';
// ignore_for_file: file_names

// ignore_for_file: use_function_type_syntax_for_parameters

class CheckBoxView extends StatefulWidget {
  const CheckBoxView({super.key});

  @override
  State<CheckBoxView> createState() => _CheckBoxViewState();
}

class _CheckBoxViewState extends State<CheckBoxView> {
  bool valueCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CheckboxListTile(
          title: const Text('With title'),
          value: valueCheck,
          onChanged: (value) {
            setState(() {
              valueCheck = value!;
            });
          },
          secondary: const Icon(Icons.check_box_sharp),
        ),
        Checkbox(
          value: valueCheck,
          onChanged: (value) {
            setState(() {
              valueCheck = value!;
            });
          },
        ),
        const Text('Sample CheckBox'),
      ],
    ));
  }
}
