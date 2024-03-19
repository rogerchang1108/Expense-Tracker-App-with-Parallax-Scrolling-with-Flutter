import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_app/widgets/new_expense.dart';
import 'package:flutter_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_app/widgets/expenses_list/expenses_list_sliver.dart';
import 'package:flutter_app/models/expense.dart';
import 'package:flutter_app/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Launch',
      amount: 3.5,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now().subtract(const Duration(minutes: 50)),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.leisure,
    ),
    Expense(
      title: 'Dinner',
      amount: 3.5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: Category.food,
    ),
    Expense(
      title: 'Keyboard',
      amount: 24.99,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: Category.work,
    ),
    Expense(
      title: 'Mountain Trip',
      amount: 53.2,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
      // Sorting registered expenses by date, newest first
      _registeredExpenses.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: isLandscape ? _buildLandscapeAppBar() : null,
      body: isLandscape ? _buildLandscapeContent() : _buildPortraitContent(),
    );
  }

  PreferredSizeWidget _buildLandscapeAppBar() {
    return AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildPortraitContent() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Expense Tracker'),
          expandedHeight: 240.0,
          floating: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Chart(
                expenses: _registeredExpenses,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        _buildSliverExpensesList(),
      ],
    );
  }

  Widget _buildSliverExpensesList() {
    return _registeredExpenses.isNotEmpty
        ? SliverExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
          )
        : const SliverFillRemaining(
            child: Center(
              child: Text('No expenses found. Start adding some!'),
            ),
          );
  }

  Widget _buildLandscapeContent() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Chart(
            expenses: _registeredExpenses,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Expanded(
          flex: 3,
          child: _buildExpensesList(),
        ),
      ],
    );
  }

  Widget _buildExpensesList() {
    return _registeredExpenses.isNotEmpty
        ? ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
          )
        : const Center(
            child: Text('No expenses found. Start adding some!'),
          );
  }
}
