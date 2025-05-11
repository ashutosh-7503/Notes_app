import 'package:flutter/material.dart';
import 'package:notes_app/screens/notes_screen.dart';

void main() {
  runApp(NotesApp());
  debugPrint('App started');
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
    );
  }
}

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Temporary app')));
  }
}
