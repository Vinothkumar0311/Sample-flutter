import 'button.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

// ignore_for_file: camel_case_types
// ignore_for_file: file_names

class viewGridList extends StatelessWidget {
  const viewGridList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GridView.count(
          crossAxisCount: 4,
          children: List.generate(viewList.length, (index) {
            // return Center(
            //   child: IndualCard(choice: viewList[index]),
            // );
            return TextButton(
              onPressed: () {
                // ButtonPage();
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => ButtonPage()));
              },
              child: Center(
                child: IndualCard(choice: viewList[index]),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ViewList {
  ViewList({required this.title, required this.icon});
  String title;
  IconData icon;
}

List<ViewList> viewList = <ViewList>[
  ViewList(title: 'Home', icon: Icons.home),
  ViewList(title: 'Contact', icon: Icons.contacts),
  ViewList(title: 'Map', icon: Icons.map),
  ViewList(title: 'Phone', icon: Icons.phone),
  ViewList(title: 'Camera', icon: Icons.camera_alt),
  ViewList(title: 'Setting', icon: Icons.settings),
  ViewList(title: 'Album', icon: Icons.photo_album),
  ViewList(title: 'WiFi', icon: Icons.wifi),
  ViewList(title: 'GPS', icon: Icons.gps_fixed),
];

class IndualCard extends StatelessWidget {
  const IndualCard({required this.choice});
  final ViewList choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Icon(choice.icon, size: 50.0),
            ),
            Text(choice.title),
          ],
        ),
      ),
    );
  }
}
