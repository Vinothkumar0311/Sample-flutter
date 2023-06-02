import 'dart:convert';
import 'package:http/http.dart';
import 'package:api_try/sample.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// ignore_for_file: use_build_context_synchronously

// ignore_for_file: avoid_print

// ignore_for_file: prefer_typing_uninitialized_variables

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Map<String, dynamic> data = {};
  Map<String, dynamic> incomingData = {};
  TextEditingController postsaTitleController = TextEditingController();
  TextEditingController commentsTitleController = TextEditingController();
  TextEditingController commentsPostidController = TextEditingController();

  List postValue = [];
  List postValueList = [];
  List commentsList = [];
  List comments = [];
  var response;

  final uri = "https://my-json-server.typicode.com/typicode/demo/db";

  valueGet() async {
    // Getting value from url
    var url = Uri.parse(uri);
    response = await get(url);
    // The response value can be encode
    print('*************   HTTP   *************');
    print("Response url ${response.statusCode}");
    if (response.statusCode == 200) {
      await decodeListValue();
    } else {
      print('URL can not be reached');
    }
  }

  @override
  void initState() {
    valueGet();
    super.initState();
  }

  decodeListValue() async {
    // Decode the response value for adding value in list
    jsonDecode(response.body).map((key, value) {
      if (key == 'posts') {
        postValue = value;
      } else if (key == 'comments') {
        comments = value;
      } else {}
      return MapEntry(key, value);
    });
    // Converting the map value into list value to show the data in ListView.bulider
    commentsList = comments.map<Comments>((e) => Comments.formJson(e)).toList();
    postValueList =
        postValue.map<PostValue>((e) => PostValue.formJson(e)).toList();
    setState(() {});
  }

  update(keyCheck, id, index) {
    print('edit');
    if (keyCheck == 'posts') {
      for (id in postValueList) {
        setState(() {
          postValueList[index].title = postsaTitleController.text;
        });
      }
      Navigator.pop(context);
    } else {
      print(keyCheck);
      for (id in commentsList) {
        setState(() {
          commentsList[index].title = commentsTitleController.text;
          commentsList[index].postId = int.parse(commentsPostidController.text);
        });
      }
      Navigator.pop(context);
    }
  }

  deleteValue(id, keyCheck) {
    // checking the value of keyCheck is posts and comments
    if (keyCheck == 'posts') {
      setState(() {
        postValueList.removeAt(id);
      });
    } else {
      setState(() {
        commentsList.removeAt(id);
      });
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Center(
              // Getting value form http
              child: Card(
                elevation: 15,
                child: TextButton(
                    onPressed: valueGet,
                    child: const Text(
                      'Load Data',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Listing the json value
            postValueList.isNotEmpty
                ? Column(
                    children: [
                      const Text(
                        'Posts Values ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 300,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: postValueList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 10,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Title : ${postValueList[index].title!}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            editValue(
                                                'posts',
                                                postValueList[index].id,
                                                postValueList.indexOf(
                                                    postValueList[index]));
                                            setState(() {
                                              postsaTitleController.text =
                                                  postValueList[index].title;
                                            });
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            deletePopUp(
                                                postValueList.indexOf(
                                                    postValueList[index]),
                                                'posts');
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
            // Listing the json value
            commentsList.isNotEmpty
                ? Column(
                    children: [
                      const Text(
                        'Comments Values ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 300,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: commentsList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.only(top: 10),
                                elevation: 10,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Title : ${commentsList[index].title!}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'PostId : ${commentsList[index].postId!}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            editValue(
                                                'comments',
                                                commentsList[index].id,
                                                commentsList.indexOf(
                                                    commentsList[index]));
                                            setState(() {
                                              commentsTitleController.text =
                                                  commentsList[index].title;
                                              commentsPostidController.text =
                                                  '${commentsList[index].postId}';
                                            });
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            deletePopUp(
                                                commentsList.indexOf(
                                                    commentsList[index]),
                                                'comments');
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future deletePopUp(id, check) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you want to delete the value'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await deleteValue(id, check);
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
        ),
      );

  Future editValue(checkPopup, id, index) => showDialog(
        context: context,
        builder: (context) => checkPopup == 'posts'
            ? AlertDialog(
                title: const Text('Update task'),
                content: TextFormField(
                  controller: postsaTitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    prefixIcon: Icon(
                      Icons.update,
                      color: Colors.grey,
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      update(checkPopup, id, index);
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context, 'cancel');
                    },
                    child: const Text('Cancel'),
                  )
                ],
              )
            : AlertDialog(
                title: const Text('Update task'),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: commentsTitleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: Icon(
                            Icons.update,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: commentsPostidController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: Icon(
                            Icons.update,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      update(checkPopup, id, index);
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context, 'cancel');
                    },
                    child: const Text('Cancel'),
                  )
                ],
              ),
      );
}
