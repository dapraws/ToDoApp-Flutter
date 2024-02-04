import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp_flutter/model/todo.dart';
import 'package:todoapp_flutter/pages/add_screen.dart';
import 'package:todoapp_flutter/pages/home_screen.dart';

final routeObserver = RouteObserver<ModalRoute>();
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/add':
            final index = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (_) => AddScreen(index: index),
              settings: settings,
            );
          default:
            return MaterialPageRoute(builder: (_) => const Placeholder());
        }
      },
    );
  }
}
