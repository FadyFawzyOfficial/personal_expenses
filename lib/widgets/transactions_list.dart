import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:personal_expenses/utilities/tracer.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function({required String id}) deleteTransaction;

  const TransactionsList({
    super.key,
    required this.transactions,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    trace();
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions add yet!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              //! You can skip unnecessary widget rebuilds if you mark a widget as const.
              //! This object will never ever change, ant that tells Flutter that since
              //! this will never change, when it rebuilds the widget tree, for this
              //! specific widget it can simply take the old widget which was in the same
              //! position, it doesn't need to recreate the object.
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Expanded(
                  child: Image(
                    image: AssetImage('assets/images/waiting.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
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
                          onPressed: () =>
                              deleteTransaction(id: transaction.id),
                          icon: const Icon(Icons.delete_rounded),
                          label: const Text('Delete'),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).errorColor,
                          ),
                        )
                      : IconButton(
                          onPressed: () =>
                              deleteTransaction(id: transaction.id),
                          color: Theme.of(context).errorColor,
                          icon: const Icon(Icons.delete_rounded),
                        ),
                ),
              );
            },
          );
  }
}
