import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/blocEvent.dart';
import 'package:todolist/cubit/todolist_cubit.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/utils/globals.dart';

class FirebaseServices {
  // FirebaseServices._();
  final _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore ;
  static final collectionName = 'TodoData';

  Future<void> addTodoData(String fieldName) async {
    try {
      final ref = firestore.collection(collectionName).doc();
      if (fieldName.isNotEmpty) {
        final Map<String, dynamic> data = {
          'title': fieldName,
          'id': ref.id,
        };
        final todo = TodoModel.fromMap(data);

        firestore.collection(collectionName).doc(ref.id).set(todo.toMap());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTodoListData(BuildContext context) async {
    try {
      final getData = await firestore.collection(collectionName).get();
      List<TodoModel> data =
          getData.docs.map((e) => TodoModel.fromMap(e.data())).toList();
      BlocProvider.of<TodoListCubit>(context).getList(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> removedataFromList(BuildContext context, String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();

      getTodoListData(navigationContext);
    } catch (e) {}
  }

  Future<void> searchData(BuildContext context, String name) async {
    try {
      QuerySnapshot<Map<String, dynamic>> getData = await firestore
          .collection(collectionName)
          .where('title', isGreaterThanOrEqualTo: name)
          .get();
      List<TodoModel> data =
          getData.docs.map((e) => TodoModel.fromMap(e.data())).toList();
      BlocProvider.of<TodoListCubit>(context).getSearchData(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData(String id, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection(collectionName)
          .doc(id)
          .update(data)
          .then((value) {
        getTodoListData(navigationContext);
      });
    } catch (e) {}
  }
}
