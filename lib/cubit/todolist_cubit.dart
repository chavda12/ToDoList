import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/cubit/todolist_state.dart';
import 'package:todolist/firebase/firebase_service.dart';
import 'package:todolist/models/todo_model.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState());

  void getList(List<TodoModel> list) {
    try {
      emit(state.copyWith(todoListData: list));
    } catch (e) {}
  }

  void getSearchData(List<TodoModel> list) {
    try {
      emit(state.copyWith(searchData: list));
    } catch (e) {}
  }

  Future<void> updateCheckedValue(int index, bool value) async {
    try {
      TodoModel todo = state.todoListData[index];
      // *complete copywith
      todo = todo.copyWith(checkedvalue: value);

      final newTodoList =
          List<TodoModel>.from(state.todoListData, growable: true);
      newTodoList[index] = todo;

      emit(state.copyWith(todoListData: newTodoList));

      // * update doc in firebase with ID
      final docID = todo.id;
      await FirebaseServices.instance.updateData(docID, todo.toMap());
      // collection("").doc(docID).update(todo.toMap())
    } catch (e) {}
  }
}
