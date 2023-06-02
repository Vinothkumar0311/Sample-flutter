import 'dart:io';
import 'dart:async';
import 'map_value.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore_for_file: avoid_print

// ignore_for_file: non_constant_identifier_names

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String TABLE_USER = "userInput";
  String COLUMN_ID = "id";
  String COLUMN_FIRSTNAME = "firstName";
  String COLUMN_LASTNAME = "lastName";
  String COLUMN_EMAILID = "emailid";
  String COLUMN_MOBILENUMBER = "mobileNumber";
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper!;
  }
  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database!;
  }

  //
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/userInput.db';
    var dbValue = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbValue;
  }

  // Creating a table
  void _createDb(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $TABLE_USER ("
      "$COLUMN_ID INTEGER PRIMARY KEY,"
      "$COLUMN_FIRSTNAME TEXT,"
      "$COLUMN_LASTNAME TEXT,"
      "$COLUMN_EMAILID TEXT,"
      "$COLUMN_MOBILENUMBER INTEGER"
      ")",
    );
  }

  // Getting the value from table and order by firstName
  Future<List<Map<String, dynamic>>> getUserInputList() async {
    Database db = await database;
    // var result = await db
    //     .rawQuery('SELECT * FORM $TABLE_USER order by $COLUMN_FIRSTNAME ASC');
    var result = await db.query(TABLE_USER, orderBy: '$COLUMN_FIRSTNAME ASC');
    return result;
  }

  // Inserting inputValue
  Future<int> insertUserInput(UserInput input) async {
    Database db = await database;
    var result = await db.insert(TABLE_USER, input.toMap());
    return result;
  }

  // Updating the inputValue
  Future<int> updateUserInput(UserInput input) async {
    var db = await database;
    var result = await db.update(TABLE_USER, input.toMap(),
        where: '$COLUMN_ID =?', whereArgs: [input.id]);
    return result;
  }

  // Deleting inputValue
  Future<int> deleteUserInput(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FORM $TABLE_USER WHERE $COLUMN_ID = $id');
    return result;
  }

  // Getting the lenght of list of a map
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.query('SELECT COUNT (*) form $TABLE_USER');
    int? result = Sqflite.firstIntValue(x);
    if (result == null) {
      print('the value return null');
    }
    return result!;
  }

  Future<List<UserInput>> getUserInputMap() async {
    var userInputList = await getUserInputMap();
    int count = userInputList.length;

    List<UserInput> userInputListConvert = <UserInput>[];

    for (int i = 0; i < count; i++) {
      userInputListConvert
          .add(UserInput.fromMap(userInputList[i] as Map<String, dynamic>));
    }
    return userInputListConvert;
  }
}
