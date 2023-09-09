import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
part 'todo_model.g.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool checkedvalue;
  @HiveField(2)
  final String id;
  TodoModel({
    this.title = '',
    this.checkedvalue = false,
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'checkedvalue': checkedvalue,
      'id': id,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] ?? '',
      checkedvalue: map['checkedvalue'] ?? false,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TodoModel copyWith({
    String? title,
    bool? checkedvalue,
    String? id,
  }) {
    return TodoModel(
      title: title ?? this.title,
      checkedvalue: checkedvalue ?? this.checkedvalue,
      id: id ?? this.id,
    );
  }
}
