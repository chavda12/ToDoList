import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist/add_adaptor.dart';
// import 'package:hive/hive.dart';
import 'package:todolist/bloc/bloc_provider.dart';
import 'package:todolist/firebase_options.dart';
import 'package:todolist/screens/todo_list_ui.dart';
import 'package:nested/nested.dart';
import 'package:todolist/utils/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Builder(builder: (context) {
    return MultiBlocProvider(
        providers: List<SingleChildWidget>.from(multiBlocProvider(context)),
        child: const MyApp());
  }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    Hive.registerAdapter(TodoModelAdapter());
    _openBox();
    super.initState();
  }

   Future _openBox() async {
    await Hive.initFlutter();
    todoBox = await Hive.openBox('todoBox');
    return;
  }

  @override
  Widget build(BuildContext context) {
    navigationContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}
