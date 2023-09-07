import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/cubit/todolist_cubit.dart';
import 'package:todolist/utils/globals.dart';

class BlocEvent {
  BlocEvent._();
  static TodoListCubit todoListCubit = navigationContext.read<TodoListCubit>();

  static final getList = todoListCubit.getList;
  static final checkedValue = todoListCubit.updateCheckedValue;
}

TodoListCubit get todoListCubit => navigationContext.read<TodoListCubit>();