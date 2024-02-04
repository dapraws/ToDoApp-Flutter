import 'package:flutter/material.dart';
import 'package:todoapp_flutter/model/todo.dart';

class ItemToDo extends StatelessWidget {
  final ToDo toDo;
  final Function(bool?) onCheck;
  final Function() onEdit;
  final Function() onDelete;

  ItemToDo({
    required this.toDo,
    required this.onCheck,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100],
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        leading: Checkbox(
          activeColor: Colors.green[800],
          value: toDo.isDone,
          onChanged: (value) => onCheck(value),
        ),
        title: Text(
          toDo.title,
          style: TextStyle(
            decoration:
                toDo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          toDo.description,
          style: TextStyle(
            decoration:
                toDo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onEdit,
              child: const Icon(Icons.edit_rounded),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
