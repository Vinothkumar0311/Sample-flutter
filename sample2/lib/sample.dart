import 'package:sample2/sample2.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String aspectRatio =
        MediaQuery.of(context).size.aspectRatio.toStringAsFixed(2);
    var orientation = MediaQuery.of(context).orientation;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Width : $screenWidth'),
            Text('Height : $screenHeight'),
            Text('AspectRatio : $aspectRatio'),
            Text('$orientation'),
            MaterialButton(
                onPressed: () {
                  print('Sample 2 file is called');
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (BuildContext context) {
                  //   return Screen();
                  // }));
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation secondaryAnimation,
                        Widget child) {
                      animation = CurvedAnimation(
                          parent: animation, curve: Curves.elasticInOut);
                      return ScaleTransition(
                        scale: animation,
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation secondaryAnimation) {
                      return Screen();
                    },
                  ));
                },
                child: const Text('Sample page 3'))
          ],
        ),
      ),
    ));
  }
}
