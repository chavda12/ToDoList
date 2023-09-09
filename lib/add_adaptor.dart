import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist/models/todo_model.dart';

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      title: fields[0] as String,
      checkedvalue: fields[1] as bool,
      id: fields[2] as String,
    );
  }


  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.checkedvalue)
      ..writeByte(2)
      ..write(obj.id);
  }
}
