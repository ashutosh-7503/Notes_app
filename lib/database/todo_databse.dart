import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  final _myBox = Hive.box('mybox');

  List TodoList = [];
  void createData() {
    TodoList = [
      ["Todo", false],
    ];
  }

  void loadData() {
    TodoList = _myBox.get("TODOLIST");
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", TodoList);
  }
}
