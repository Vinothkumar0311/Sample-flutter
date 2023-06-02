import 'package:flutter/material.dart';

class Sample3 extends StatefulWidget {
  const Sample3({super.key});

  @override
  State<Sample3> createState() => _Sample3State();
}

class _Sample3State extends State<Sample3> {
  @override
  Widget build(BuildContext context) {
    String aspectRatioValue =
        MediaQuery.of(context).size.aspectRatio.toStringAsFixed(2);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: AspectRatio(
          aspectRatio: double.parse(aspectRatioValue),
          child: Container(
            width: 100.0,
            height: 50.0,
            color: Colors.green,
            child:Center(child:Text(aspectRatioValue))
          ),
        ),
      ),
    );
  }
}
