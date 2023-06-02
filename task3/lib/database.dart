import 'dart:io';
import 'dart:async';
import 'map_value.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// ignore_for_file: constant_identifier_names

class DatabaseProvider {
  static const String TABLE_USER = "userInput";
  static const String COLUMN_ID = "id";
  static const String COLUMN_FIRSTNAME = "firstName";
  static const String COLUMN_LASTNAME = "lastName";
  static const String COLUMN_EMAILID = "emailid";
  static const String COLUMN_MOBILENUMBER = "mobileNumber";

  // DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider();

  late Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating userInput table");

        await database.execute(
          "CREATE TABLE $TABLE_USER ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_FIRSTNAME TEXT,"
          "$COLUMN_LASTNAME TEXT,"
          "$COLUMN_EMAILID TEXT,"
          "$COLUMN_MOBILENUMBER INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<UserInput>> getuserInputs() async {
    final db = await database;
    var userInputs = await db.query(TABLE_USER, columns: [
      COLUMN_ID,
      COLUMN_FIRSTNAME,
      COLUMN_LASTNAME,
      COLUMN_EMAILID,
      COLUMN_MOBILENUMBER
    ]);
    List<UserInput> userInput = <UserInput>[];
    for (var currentuserInputs in userInputs) {
      UserInput userInputs = UserInput.fromMap(currentuserInputs);
      userInput.add(UserInput as UserInput);
    }
    return userInput;
  }

  Future<UserInput> insert(UserInput userInput) async {
    final db = await database;
    userInput.id = await db.insert(TABLE_USER, userInput.toMap());
    return userInput;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_USER,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(UserInput userInput) async {
    final db = await database;

    return await db.update(
      TABLE_USER,
      userInput.toMap(),
      where: "id = ?",
      whereArgs: [userInput.id],
    );
  }
}
