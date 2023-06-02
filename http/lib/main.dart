import 'package:api_try/get_post.dart';
import 'package:flutter/material.dart';
import 'package:api_try/main_page.dart';
// import 'package:api_try/xml_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 93, 0, 255)),
        useMaterial3: true,
      ),
      home: const GetPostTry(title: 'Api Demo'),
    );
  }
}
