import 'package:flutter/material.dart';

class Cardmsg extends StatelessWidget {
  const Cardmsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 216, 215, 215),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.contact_page),
                hintText: 'Enter the input field',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                labelText: 'InputField3',
                labelStyle: TextStyle(fontWeight: FontWeight.bold)),
          )
          // ListTile(
          //   title: Text('Sample Card'),
          // )
        ],
      ),
    );
  }
}
