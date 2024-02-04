import 'package:flutter/material.dart';
import 'package:todoapp_flutter/data/hive_database.dart';
import 'package:todoapp_flutter/widgets/empty_data.dart';
import 'package:todoapp_flutter/widgets/item_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hiveDatabase = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('To Do App'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: hiveDatabase.getToDos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final totalData = snapshot.data!.length;
              final totalActive = snapshot.data!
                  .map((toDo) => toDo.isDone)
                  .where((element) => element == false)
                  .toList()
                  .length;
              return snapshot.data!.isEmpty
                  ? const EmptyData()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '$totalActive active tasks out of $totalData',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final toDos = snapshot.data!;
                              return ItemToDo(
                                toDo: toDos[index],
                                onCheck: (value) async {
                                  await hiveDatabase.updateStatus(
                                    index,
                                    toDos[index],
                                  );
                                },
                                onEdit: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/add',
                                    arguments: index,
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                onDelete: () async {
                                  await hiveDatabase.deleteTodo(index);
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        onPressed: () => Navigator.pushNamed(context, '/add').then((value) {
          setState(() {});
        }),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
