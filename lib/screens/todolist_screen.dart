// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/database/todo_databse.dart';
import 'package:notes_app/utils/dialog_box.dart';
import 'package:notes_app/utils/todo_item.dart';

class TodolistScreen extends StatefulWidget {
  const TodolistScreen({super.key});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  int index = 1;
  final items = <Widget>[
    Icon(Icons.notes, size: 30),
    Icon(Icons.add_box, size: 30),
  ];

  final _myBox = Hive.box("mybox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createData();
      print("object");
    } else {
      db.loadData();
      print(db.TodoList);
    }
    super.initState();
  }

  final _controller = TextEditingController();
  void onSave() {
    setState(() {
      db.TodoList.add([_controller.text, false]);
      db.updateDatabase();
      db.loadData();
      _controller.clear();
      Navigator.of(context).pop();
    });
  }

  void createNewTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: () => onSave(),
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.TodoList[index][1] = !db.TodoList[index][1];
      db.updateDatabase();
      db.loadData();
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.TodoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text('To-Do List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: db.TodoList.length,

        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: db.TodoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            todoText: db.TodoList[index][0],
            onPressed: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
