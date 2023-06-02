import 'package:flutter/material.dart';

class ListBulid extends StatelessWidget {
  const ListBulid({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text(
          'List View using Icons',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map Icon'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone Icon'),
        ),
        ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text('ContactMail Icon'),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Add Icon'),
        )
      ],
    );
  }
}

// class LongListView extends StatelessWidget {
//   final List<String> sampleText;

//   const LongListView({required this.sampleText});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: sampleText.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(sampleText[index]),
//         );
//       },
//     );
//   }
// }
