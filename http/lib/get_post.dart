import 'dart:convert';
import 'package:http/http.dart';
import 'package:api_try/sample.dart';
import 'package:flutter/material.dart';

// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: avoid_print
// import 'package:http/http.dart' as http;

class GetPostTry extends StatefulWidget {
  const GetPostTry({super.key, required this.title});
  final String title;
  @override
  State<GetPostTry> createState() => _GetPostTryState();
}

class _GetPostTryState extends State<GetPostTry> {
  var response;
  List posts = [];
  final uri = "https://my-json-server.typicode.com/typicode/demo/posts";

  fecthData() async {
    var url = Uri.parse(uri);
    response = await get(url);
    // The response value can be encode
    print('*************   HTTP   *************');
    print("Response url ${response.statusCode}");
    response = jsonDecode(response.body);
    posts = response.map<PostValue>((e) => PostValue.formJson(e)).toList();
    setState(() {});
  }

  postData() async {
    try {
      final response = await post(Uri.parse(uri), body: {"title": "sample"});
      print(response.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    fecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: postData, child: const Text('Post Value'))),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UserId : ${posts[index].id} \n Title : ${posts[index].title}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
