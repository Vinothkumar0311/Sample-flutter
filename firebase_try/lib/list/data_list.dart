import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_try/value.dart';
import 'package:firebase_try/form/update.dart';
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: avoid_print

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List _userList = [];
  bool _isLoading = true;

  fetchData() async {
    final url =
        Uri.https('sample-b6a55-default-rtdb.firebaseio.com', 'user-list.json');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
        _userList = [];
      });
      return;
    }
    final Map<String, dynamic> dataValue = jsonDecode(response.body);
    final List emptyList = [];
    for (final item in dataValue.entries) {
      emptyList.add(
        UserList(
          key: item.key,
          name: item.value['name'],
          emailid: item.value['emailid'],
          mobileNumber: item.value['mobileNumber'],
          password: item.value['password'],
        ),
      );
    }
    setState(() {
      // _isrefresh = 0;

      _userList = emptyList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  deleteValue(item) async {
    print(item);
    final url = Uri.https(
        'sample-b6a55-default-rtdb.firebaseio.com', 'user-list/$item.json');
    await http.delete(url);
    // setState(() {
    //   fetchData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('User List'),
            centerTitle: true,
          ),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.red[700],
                  ),
                )
              : _userList.isEmpty
                  ? const Center(
                      child: Card(
                        elevation: 20,
                        child: SizedBox(
                          width: 250,
                          height: 100,
                          child: Center(
                            child: Text(
                              'There is no value in list',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      itemCount: _userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.redAccent[400],
                          margin: const EdgeInsets.only(
                              top: 20, left: 15, right: 15),
                          elevation: 15,
                          child: ListTile(
                            title: Text(
                              'Name : ${_userList[index].name!}\nEmailid: ${_userList[index].emailid!}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                                'MobileNumber: ${_userList[index].mobileNumber!}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return UpdateValue(
                                          user: _userList[index],
                                        );
                                      },
                                    ));
                                    await fetchData();

                                    setState(() {
                                      fetchData();
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteDialog(_userList[index].key!);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
    );
  }

  Future deleteDialog(id) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              'Are you want to delete value',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            actions: [
              Row(
                children: [
                  const SizedBox(width: 50),
                  ElevatedButton(
                      onPressed: () {
                        deleteValue(id);
                        Navigator.of(context).pop();
                        setState(() {
                          fetchData();
                        });
                      },
                      child: const Text('Ok')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                ],
              )
            ],
          );
        },
      );
}
