import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  runApp(Builder(
    builder: (context) {
      return MultiBlocProvider(
          providers: 
            List<SingleChildWidget>.from(multiBlocProvider(context))
          ,
        child: const MyApp());
    }
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    navigationContext = context ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}
