import 'package:api_try/sample.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as prefix;
// ignore_for_file: avoid_print


class SampleDio extends StatefulWidget {
  const SampleDio({super.key});

  @override
  State<SampleDio> createState() => _SampleDioState();
}

class _SampleDioState extends State<SampleDio> {
  List dumyList = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Sample'),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    // Getting value from url
                    var response = await prefix.Dio().get(
                        "https://my-json-server.typicode.com/typicode/demo/posts");
                    // The response value can't be encode
                    print('*************   DIO   *************');
                    // print("Response url ${response.statusCode}");
                    if (response.statusCode == 200) {
                      print('Response body $response');
                    } else {
                      print("The value from link can't be get");
                    }
                    var dumy = response.data as List<dynamic>;
                    // print('*************   DATA   *************');
                    // print(incomingData);
                    dumyList = dumy
                        .map<Comments>((e) => Comments.formJson(e))
                        .toList();

                    print('DumyList : ${dumyList.toString()}');
                    setState(() {});
                  },
                  child: const Text(
                    'Get Data',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dumyList.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          title: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UserId : ${dumyList[index].id!}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Title : ${dumyList[index].title}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                       
                      ],
                    ),
                  )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
