// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_todo/model/user.dart';

class DatabaseHelper {
  static const dbName = 'TodoApp.db';
  static const dbVersion = 1;
  static const dbTable = "StudentTable";
  static const studentId = 'id';
  static const studentName = 'name';
  static const studentEmail = 'email';
  static const studentAge = 'age';
  static const studentBatchNo = 'batch_no';

  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $dbTable(
        $studentId INTEGER PRIMARY KEY,
        $studentName TEXT NOT NULL,
        $studentAge INTEGER NOT NULL,
        $studentEmail TEXT UNIQUE NOT NULL,
        $studentBatchNo TEXT NOT NULL 
      )
      ''');
  }

//Check Email Availability
  Future<bool> checkEmailAvailabilty(String email) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> result = await db!
        .query(dbTable, where: '$studentEmail = ?', whereArgs: [email]);
    return result.isEmpty;
  }

//add Student
  Future<int?> addStudentToDB(User student) async {
    Database? db = await instance.database;
    int id = await db!.insert(dbTable, student.toJson());
    return id;
  }

  //get List of Students
  Future<List<User>> getListOfStudents() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> result = await db!.query(dbTable);
    return result.map((e) => User.fromJson(e)).toList();
  }

  //update
  Future<int> updateStudentDetails(User student) async {
    print(student.id);
    Database? db = await instance.database;
    final id = await db!.update(dbTable, student.toJson(),
        where: '$studentId = ?', whereArgs: [student.id]);
    return id;
  }
}
