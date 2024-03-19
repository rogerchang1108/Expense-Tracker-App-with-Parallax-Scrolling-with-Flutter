import 'package:flutter/material.dart';

import 'package:flutter_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter_app/models/expense.dart';

class SliverExpensesList extends StatelessWidget {
  const SliverExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Dismissible(
              key: ValueKey(expenses[index]
                  .id), // Assuming Expense has a unique 'id' field
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                ),
              ),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            );
          },
          childCount: expenses.length,
        ),
      ),
    );
  }
}
