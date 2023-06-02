import 'dynamic_field.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// ignore_for_file: must_be_immutable

// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: no_logic_in_create_state

class AddTaskPage extends StatefulWidget {
  final nameController;
  VoidCallback onsave;
  AddTaskPage({super.key, required this.nameController, required this.onsave});

  @override
  State<AddTaskPage> createState() =>
      _AddTaskPageState(nameController: nameController, onsave: onsave);
}

class _AddTaskPageState extends State<AddTaskPage> {
  final nameController;
  VoidCallback onsave;
  _AddTaskPageState({required this.nameController,required this.onsave});
  List fieldList = [];
  addListField() {
    if (fieldList.length < 3) {
      fieldList.add(const InputField());
      setState(() {});
    } else {
      // Fluttertoast.showToast(
      //     msg: 'Morethan four input field blocked',
      //     gravity: ToastGravity.CENTER,
      //     fontSize: 25,
      //     backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 43, 197, 123),
      ),
      body: Form(
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  Container(
                      padding:
                          const EdgeInsets.only(top: 85, left: 50, right: 50),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        hintText: 'Enter task to add',
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     addListField();
                        //   },
                        //   icon: const Icon(Icons.add),
                        // ),
                        
                      ),
                    ),
                  ),
                  // Flexible(
                  //   child: ListView.builder(
                  //     itemCount: fieldList.length,
                  //     itemBuilder: (context, index) => fieldList[index],
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  nameController.text = '';
                  if (name.isNotEmpty) {
                    // form.add(name);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                          
                    //     },
                    //   ),
                    // );
                    onsave;
                  } else {
                    // Fluttertoast.showToast(
                    //     msg: 'Field is Empty',
                    //     gravity: ToastGravity.CENTER,
                    //     fontSize: 25,
                    //     backgroundColor: Colors.red);
                  }
                },
                child: const Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
