import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/blocEvent.dart';
import 'package:todolist/cubit/todolist_cubit.dart';
import 'package:todolist/cubit/todolist_state.dart';
import 'package:todolist/firebase/firebase_service.dart';
import 'package:todolist/models/todo_model.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    firebaseServices.getTodoListData(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: BlocBuilder<TodoListCubit, TodoListState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey.withOpacity(0.2),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.menu),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Center(
                            child: TextField(
                              cursorColor: Colors.black,
                              controller: searchController,
                              onChanged: (val) {
                                firebaseServices.searchData(context, val);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  hintStyle: TextStyle(),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'All ToDos',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.text.length > 0
                            ? state.searchData.length
                            : state.todoListData.length,
                        itemBuilder: (context, index) => todoListdata(index,
                            searchText: searchController.text.length > 0),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(3, 3),
                                blurRadius: 2)
                          ]),
                      child: TextField(
                        autofocus: true,
                        controller: _controller,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            hintText: 'add a new todo item',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(.6)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_controller.text.length > 0) {
                        await firebaseServices.addTodoData(_controller.text);
                        _controller.text = '';
                        await firebaseServices.getTodoListData(context);
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        "+",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    ));
  }

  Widget todoListdata(int index, {bool searchText = false}) {
    return BlocBuilder<TodoListCubit, TodoListState>(builder: (context, state) {
      final allList = searchText ? state.searchData : state.todoListData;
      final todo = allList[index];
      return allList.length>0? 
      Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: todo.checkedvalue,
                      onChanged: (val) {
                        todoListCubit.updateCheckedValue(index, val ?? false);
                        //  BlocEvent.updateCheckedValue(index,val);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(todo.title),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await firebaseServices.removedataFromList(context, todo.id);
                  },
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    width: 30,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
        ]
  
      ):Center(child: Text('No Data Found',style: TextStyle(color: Colors.black),));
   
    });
  }
}
