import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final void Function({required String id}) deleteTransaction;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          child: Padding(
            // This makes the Text Container Touch the CircleAvatar Line
            padding: const EdgeInsets.all(16),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        // When we have more width, I want to show a button with a
        // text next to it.
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () => deleteTransaction(id: transaction.id),
                icon: const Icon(Icons.delete_rounded),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).errorColor,
                ),
              )
            : IconButton(
                onPressed: () => deleteTransaction(id: transaction.id),
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete_rounded),
              ),
      ),
    );
  }
}
