import 'home_page.dart';
import 'package:flutter/material.dart';

class Viewdata extends StatefulWidget {
  const Viewdata({super.key});

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Data List'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {},
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) => const MainPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
