import 'package:flutter/material.dart';

// import 'package:flutter_app/flutter_internals/ui_rebuild_demo.dart';
import 'package:flutter_app/flutter_internals/keys/todo_list.dart';
import 'package:flutter_app/flutter_internals/ui_rebuild_demo.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        body: const UIRebuildDemo1(),
        // body: const TodoList(),
      ),
    );
  }
}
