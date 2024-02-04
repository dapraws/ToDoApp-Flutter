import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool isDone;

  ToDo({
    required this.title,
    required this.description,
    this.isDone = false,
  });
}

List<ToDo> todos = [];
