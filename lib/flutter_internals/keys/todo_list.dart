import 'package:flutter/material.dart';

import 'package:flutter_app/flutter_internals/keys/checkable_todo_item.dart';
// import 'package:flutter_app/flutter_internals/keys/todo_item.dart';

class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  var _order = 'asc';
  final _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _changeOrder,
            icon: Icon(
              _order == 'asc' ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
            label: Text('Sort ${_order == 'asc' ? 'Ascending' : 'Descending'}'),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              // for (final todo in _orderedTodos) TodoItem(todo.text, todo.priority),
              for (final todo in _orderedTodos)
                CheckableTodoItem(
                  // key: ValueKey(todo.text), // or ObjectKey(todo)
                  todo.text,
                  todo.priority,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
