import 'package:sqflite/sqflite.dart';

import '../models/task_db.dart';

class DBServices {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  Future<String> get fullPath async {
    return "${await getDatabasesPath()}task.db";
  }

  Future<Database> _initDB() async {
    final path = await fullPath;
    var db = await openDatabase(path,
        version: 1, onCreate: _createDB, singleInstance: true);
    return db;
  }

  Future _createDB(Database database, int version) async {
    await TaskDB().createTable(database);
  }
}
