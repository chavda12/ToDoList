import 'package:todolist/models/todo_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoListState {
final List<TodoModel> todoListData;
final List<TodoModel> searchData;
    bool? checkedValue;

  TodoListState({
     this.todoListData = const [],
     this.searchData = const [],
     this.checkedValue = false
  });

  TodoListState copyWith({
    List<TodoModel>? todoListData,
    List<TodoModel>? searchData,
    bool? checkedValue,
  }) {
    return TodoListState(
      todoListData: todoListData ?? this.todoListData,
      searchData: searchData ?? this.searchData,
      checkedValue: checkedValue ?? this.checkedValue,
    );
  }
}
