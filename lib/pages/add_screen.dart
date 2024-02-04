import 'package:flutter/material.dart';
import 'package:todoapp_flutter/data/hive_database.dart';
import 'package:todoapp_flutter/model/todo.dart';
import 'package:todoapp_flutter/widgets/todo_textfilled.dart';

class AddScreen extends StatefulWidget {
  final int? index;
  const AddScreen({
    this.index,
    super.key,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final hiveDatabase = HiveDatabase();
  ToDo? _toDo;

  Future<ToDo?> loadToDo() async {
    if (widget.index != null) {
      _toDo = await hiveDatabase.getToDoByIndex(widget.index!);
    }
    return _toDo;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(widget.index != null ? 'Edit' : 'Add'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: loadToDo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ToDoTextField(
                      hint: 'Title',
                      controller: titleController
                        ..text = _toDo != null ? _toDo!.title : '',
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    ToDoTextField(
                      hint: 'Description',
                      controller: descriptionController
                        ..text = _toDo != null ? _toDo!.description : '',
                      inputAction: TextInputAction.done,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[300]),
                      ),
                      onPressed: () async {
                        if (widget.index != null) {
                          _toDo = ToDo(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          await hiveDatabase.updateToDo(widget.index!, _toDo!);
                        } else {
                          final toDo = ToDo(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          await hiveDatabase.addToDo(toDo);
                        }
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: Text(
                        widget.index != null ? 'Edit' : 'Save',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
