import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool isPhone(BuildContext context) => MediaQuery.of(context).size.width < 600;
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;
  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: GridView.count(
              crossAxisCount: isPortrait ? 3 : 5,
              children: List.generate(
                  30,
                  (index) => Card(
                        color: Colors.amber,
                        child: Center(
                          child: Text('Item ${index+1}'),
                        ),
                      )),
            ),
          ),
        );
      });
}
