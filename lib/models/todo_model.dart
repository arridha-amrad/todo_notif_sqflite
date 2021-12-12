import 'package:todo_notif_sqflite/database/todo/todo_fields.dart';

class Todo {
  int? id;
  bool isComplete;
  String title;
  String note;
  DateTime date;
  String startTime;
  String endTime;
  int remind;
  String repeat;
  int color;

  Todo({
    this.id,
    required this.isComplete,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    required this.color,
  });

  factory Todo.fromMap(Map<String, Object?> map) => Todo(
        id: map["__id"] as int,
        isComplete: map["isComplete"] == 1,
        title: map["title"] as String,
        note: map["note"] as String,
        date: map["date"] as DateTime,
        startTime: map["startTime"] as String,
        endTime: map["endTime"] as String,
        remind: map["remind"] as int,
        repeat: map["repeat"] as String,
        color: map["color"] as int,
      );

  Map<String, Object?> toMap() => {
        TodoFields.title: title,
        TodoFields.isComplete: isComplete ? 1 : 0,
        TodoFields.note: note,
        TodoFields.date: date.toIso8601String(),
        TodoFields.startTime: startTime,
        TodoFields.endtime: endTime,
        TodoFields.remind: remind,
        TodoFields.repeat: repeat,
        TodoFields.color: color,
      };

  Todo copy(
          {int? id,
          String? title,
          String? note,
          bool? isComplete,
          DateTime? date,
          String? startTime,
          String? endTime,
          int? remind,
          String? repeat,
          int? color}) =>
      Todo(
        id: id ?? id,
        isComplete: isComplete ?? this.isComplete,
        title: title ?? this.title,
        note: note ?? this.note,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        remind: remind ?? this.remind,
        repeat: repeat ?? this.repeat,
        color: color ?? this.color,
      );
}
