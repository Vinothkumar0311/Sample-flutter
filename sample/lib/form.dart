import 'card.dart';
import 'package:flutter/material.dart';

class FormWigets extends StatelessWidget {
  const FormWigets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter the input field',
                  labelText: 'InputField1'),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 45, top: 25),
              child: TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter the input field',
                    labelText: 'InputField2'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 45, top: 25),
              child: ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: const Text('Check Alert'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 45, top: 25),
              child: const Cardmsg(),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Simple Alert"),
    content: const Text("Click ok to next step."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
