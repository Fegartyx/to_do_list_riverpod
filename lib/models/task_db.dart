import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_riverpod/models/task.dart';

import '../services/db_services.dart';

class TaskDB {
  final tableName = "todo";

  Future createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isCompleted BOOLEAN NOT NULL
      )
    ''');
  }

  Future<int> create({
    required String title,
    required String description,
  }) async {
    final db = await DBServices().database;
    return await db.insert(tableName, {
      "title": title,
      "description": description,
      "isCompleted": 0,
    });
  }

  Future<List<Task>> read() async {
    final db = await DBServices().database;
    final todos = await db.query(tableName);
    final data = todos.map((e) => Task.fromMap(e)).toList();
    // debugPrint("Task Read" + data.map((e) => e.id).toList().toString());
    return data;
  }

  Future<List<Task>> readById(int id) async {
    final db = await DBServices().database;
    final todos = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return todos.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> update(
    int isCompleted, {
    required int id,
    required String title,
    String? description,
  }) async {
    try {
      final db = await DBServices().database;
      debugPrint(isCompleted.toString());
      return await db.update(
          tableName,
          {
            "title": title,
            "description": description,
            "isCompleted": isCompleted,
          },
          where: "id = ?",
          whereArgs: [id]);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<int> delete(int id) async {
    final db = await DBServices().database;
    return await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
