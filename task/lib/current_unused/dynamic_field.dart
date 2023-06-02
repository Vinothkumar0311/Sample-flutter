import 'package:flutter/material.dart';

// class FieldDynamic extends StatefulWidget {
//   const FieldDynamic({super.key});

//   @override
//   State<FieldDynamic> createState() => _FieldDynamicState();
// }

// class _FieldDynamicState extends State<FieldDynamic> {
//   List fieldList = [];

//   addListField() {
//     fieldList.add(const InputField());
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           child: Column(
//             children: [
//               Flexible(
//                   child: ListView.builder(
//                 itemCount: fieldList.length,
//                 itemBuilder: (context, index) => fieldList[index],
//               ))
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             addListField();
//           },
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

class InputField extends StatelessWidget {
  const InputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50),
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Task',
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          hintText: 'Enter task to add',
        ),
      ),
    );
  }
}
