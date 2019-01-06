/**
 * CRUD data in offline database (in-memory)
 */

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/models/task.dart';

class DbTask {
  static final DbTask _bookDatabase = new DbTask._internal();
  final String tableName = "Tasks";
  Database db;
  bool didInit = false;

  static DbTask get() {
    return _bookDatabase;
  }

  DbTask._internal();


  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return db;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $tableName ("
                  "${Task.db_uuid} STRING PRIMARY KEY,"
                  "${Task.db_id} TEXT,"
                  "${Task.db_subject} TEXT,"
                  "${Task.db_description} TEXT,"
                  "${Task.db_star} BIT,"
                  "${Task.db_notes} TEXT"
                  ")");
        });
    didInit = true;


  }

  /// Get a book by its id, if there is not entry for that ID, returns null.
  Future<Task> getTask(String id) async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${Task.db_id} = "$id"');
    if(result.length == 0)return null;
    return new Task.fromMap(result[0]);
  }

  /// Get all books with ids, will return a list with all the books found
  Future<List<Task>> getTasks(List<String> ids) async{
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    var idsString = ids.map((it) => '"$it"').join(',');
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${Task.db_id} IN ($idsString)');
    List<Task> tasks = [];
    for(Map<String, dynamic> item in result) {
      tasks.add(new Task.fromMap(item));
    }
    return tasks;
  }

  /// Get all books
  Future<List<Task>> getAllTasks() async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName');
    List<Task> tasks = [];
    for(Map<String, dynamic> item in result) {
      tasks.add(new Task.fromMap(item));
    }
    return tasks;
  }


  Future<List<Task>> getFavoriteTasks() async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${Task.db_star} = "1"');
    if(result.length == 0)return [];
    List<Task> tasks = [];
    for(Map<String,dynamic> map in result) {
      tasks.add(new Task.fromMap(map));
    }
    return tasks;
  }


  //TODO escape not allowed characters eg. ' " '
  /// Inserts or replaces the book.
  Future updateTask(Task task) async {
    var db = await _getDb();
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT OR REPLACE INTO '
              '$tableName(${Task.db_uuid}, '
              '${Task.db_id}, ${Task.db_subject}, '
              '${Task.db_description}, '
              '${Task.db_star},'
              '${Task.db_notes})'
              ' VALUES(?, ?, ?, ?, ?, ?)',
          [
            task.uuid,
            task.id,
            task.subject,
            task.description,
            task.starred ? 1 : 0,
            task.notes
          ]);
    });
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

}