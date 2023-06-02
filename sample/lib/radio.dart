import 'package:flutter/material.dart';

class ButtonRadio extends StatefulWidget {
  const ButtonRadio({super.key});

  @override
  State<ButtonRadio> createState() => _ButtonRadioState();
}

class _ButtonRadioState extends State<ButtonRadio> {
  var startingValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: const Text('RadioButton1'),
            leading: Radio(
              value: 1,
              groupValue: startingValue,
              onChanged: ((value) {
                setState(() {
                  startingValue = value!;
                });
              }),
            ),
          ),
          ListTile(
            title: const Text('RadioButton2'),
            leading: Radio(
              value: 2,
              groupValue: startingValue,
              onChanged: ((value) {
                setState(() {
                  startingValue = value!;
                });
              }),
            ),
          ),
          ListTile(
            title: const Text('RadioButton3'),
            leading: Radio(
              value: 3,
              groupValue: startingValue,
              onChanged: ((value) {
                setState(() {
                  startingValue = value!;
                });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
