import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldsView extends StatelessWidget {
  const FieldsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(left: 25, right: 15),
          child: const TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'SampleField One',
              hintText: 'Sample field',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 0, left: 25, right: 15),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'SampleFirld One',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 10,
          ),
        ),
      ]),
    );
  }
}
