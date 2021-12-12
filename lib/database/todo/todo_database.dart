import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:todo_notif_sqflite/database/todo/todo_fields.dart';
import 'package:todo_notif_sqflite/models/todo_model.dart';

class TodoDatabase {
  static TodoDatabase instance = TodoDatabase._init();
  TodoDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      var dbPath = await getDatabasesPath();
      final path = join(dbPath, 'todo.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const strType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableOfTodo (
        ${TodoFields.id} $idType,
        ${TodoFields.title} $strType,
        ${TodoFields.note} $strType,
        ${TodoFields.isComplete} $intType,
        ${TodoFields.color} $intType,
        ${TodoFields.date} $strType,
        ${TodoFields.remind} $intType,
        ${TodoFields.repeat} $strType,
        ${TodoFields.endtime} $strType,
        ${TodoFields.startTime} $strType
      )
    ''');
  }

  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final listOfMap = await db.query(
      tableOfTodo,
      columns: TodoFields.values,
      orderBy: '${TodoFields.id} DESC',
    );
    return listOfMap.map((map) => Todo.fromMap(map)).toList();
  }

  Future<Todo> getTodo(int id) async {
    final db = await instance.database;
    final listOfMap = await db.query(
      tableOfTodo,
      columns: TodoFields.values,
      where: '${TodoFields.id}=?',
      whereArgs: [id],
    );
    return Todo.fromMap(listOfMap.first);
  }

  Future<Todo> createTodo(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableOfTodo, todo.toMap());
    return todo.copy(id: id);
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableOfTodo,
      where: '${TodoFields.id}=?',
      whereArgs: [id],
    );
  }

  Future<Todo> updateTodo(Todo todo, int id) async {
    final db = await instance.database;
    await db.update(
      tableOfTodo,
      todo.toMap(),
      where: '${TodoFields.id}=?',
      whereArgs: [id],
    );
    return getTodo(id);
  }
}
