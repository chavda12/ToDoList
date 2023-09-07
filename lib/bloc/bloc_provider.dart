import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/cubit/todolist_cubit.dart';

List multiBlocProvider(context) {
  return [
    BlocProvider(create: (context) => TodoListCubit()),
  ];
}
