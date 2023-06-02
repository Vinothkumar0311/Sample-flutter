import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_try/value.dart';
import 'package:firebase_try/list/data_list.dart';
// ignore_for_file: avoid_print

// ignore_for_file: unused_field


class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.title});
  final String title;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List _userList = [];
  final nameController = TextEditingController();
  final emailidController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var passwordVisble = true;

  final url =
      Uri.https('sample-b6a55-default-rtdb.firebaseio.com', 'user-list.json');
  addValue() async {
    await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: json.encode(
        {
          'name': nameController.text,
          'emailid': emailidController.text,
          'mobileNumber': mobileNumberController.text,
          'password': passwordController.text,
        },
      ),
    );
    nameController.clear();
    emailidController.clear();
    mobileNumberController.clear();
    passwordController.clear();
    await fetchData();
  }

  fetchData() async {
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    if (response.body == 'null') {
      setState(() {});
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
      _userList = emptyList;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 25, top: 30, right: 25),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name field is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailidController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Emailid'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Emailid field is empty';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Email is not match has condition';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mobileNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('MobileNumber'),
                  ),
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile field is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisble = !passwordVisble;
                        });
                      },
                      icon: Icon(!passwordVisble
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password field is empty';
                    } else {
                      return null;
                    }
                  },
                  obscureText: passwordVisble,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 55),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await addValue();
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(width: 15),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const MainPage();
                              },
                            )).then((value) {
                              setState(() {});
                            });
                          },
                          child: const Text(
                            'View List',
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
