import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/screens/notes_screen.dart';
import 'package:notes_app/screens/todolist_screen.dart';
// import 'package:notes_app/screens/notes_screen.dart';
// import 'package:notes_app/screens/todolist_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("mybox");
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
      home: const NotesScreen(),
      routes: {
        '/notes_screen': (context) => NotesScreen(),
        '/todolist_screen': (context) => TodolistScreen(),
      },
    );
  }
}
