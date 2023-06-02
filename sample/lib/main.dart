import 'form.dart';
import 'list.dart';
import 'radio.dart';
import 'fields.dart';
import 'button.dart';
import 'checkBox.dart';
import 'package:sample/tryGrid.dart';
import 'package:flutter/material.dart';

void main() => {runApp(const MyApp())};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      // home: AppBar(
      //   title: const Text('Sample'),
      // ),

      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Sample'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.text_fields), text: "InputFields"),
              Tab(icon: Icon(Icons.tab_outlined), text: "Alert"),
              Tab(icon: Icon(Icons.smart_button_outlined), text: "Button"),
              Tab(icon: Icon(Icons.list), text: "ListView"),
              Tab(icon: Icon(Icons.grid_3x3_rounded), text: "GridView"),
              Tab(icon: Icon(Icons.check_box), text: "CheckBox"),
              Tab(icon: Icon(Icons.radio_button_checked), text: "RadioButton"),
            ]),
          ),
          drawer: Drawer(
            child: ListView(
              children: const <Widget>[
                DrawerHeader(
                  child: Text('Text1'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.chat_rounded),
                  title: Text('Message'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FieldsView(),
              FormWigets(),
              ButtonPage(),
              ListBulid(),
              viewGridList(),
              CheckBoxView(),
              ButtonRadio()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
