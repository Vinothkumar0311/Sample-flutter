import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_try/value.dart';
// ignore_for_file: avoid_print


// ignore_for_file: use_build_context_synchronously

class UpdateValue extends StatefulWidget {
  final UserList user;
  const UpdateValue({
    super.key,
    required this.user,
  });

  @override
  State<UpdateValue> createState() => _UpdateValue();
}

class _UpdateValue extends State<UpdateValue> {
  final nameController = TextEditingController();
  final emailidController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print(widget.user.key);
    print(widget.user);
    nameController.text = widget.user.name ?? '';
    emailidController.text = widget.user.emailid ?? '';
    mobileNumberController.text = widget.user.mobileNumber ?? '';
    super.initState();
  }

  updateValue() {
    final url = Uri.https('sample-b6a55-default-rtdb.firebaseio.com',
        'user-list/${widget.user.key}.json');
    http.put(
      url,
      body: json.encode(
        {
          'name': nameController.text,
          'emailid': emailidController.text,
          'mobileNumber': mobileNumberController.text,
          'password': widget.user.password
        },
      ),
    );
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
            title: const Text('InputField'),
            centerTitle: true),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: Icon(Icons.person_rounded),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      } else {
                        return null;
                      }
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                child: TextFormField(
                  controller: emailidController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Emailid',
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is empty";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Invalid emailid formate";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 45, top: 10, right: 45),
                child: TextFormField(
                    controller: mobileNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelText: 'MobileNumber',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      } else {
                        return null;
                      }
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 45, right: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await updateValue();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Update'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'notchange');
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
