import 'package:hive/hive.dart';
import 'package:todoapp_flutter/model/todo.dart';

class HiveDatabase {
  final String boxName = 'toDoBox';

  Future<void> addToDo(ToDo toDo) async {
    final box = await Hive.openBox<ToDo>(boxName);
    await box.add(toDo);
  }

  Future<List<ToDo>> getToDos() async {
    final box = await Hive.openBox<ToDo>(boxName);
    return box.values.toList();
  }

  Future<ToDo?> getToDoByIndex(int index) async {
    final box = await Hive.openBox<ToDo>(boxName);
    return box.values.toList()[index];
  }

  Future<void> deleteTodo(int index) async {
    final box = await Hive.openBox<ToDo>(boxName);
    await box.delete(index);
  }

  Future<void> updateToDo(int index, ToDo toDo) async {
    final box = await Hive.openBox<ToDo>(boxName);
    await box.putAt(index, toDo);
  }

  Future<void> updateStatus(int index, ToDo toDo) async {
    final box = await Hive.openBox<ToDo>(boxName);
    toDo.isDone = !toDo.isDone;
    await box.put(index, toDo);
  }
}
