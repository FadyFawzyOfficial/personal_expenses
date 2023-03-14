import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

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
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions add yet!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
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
                  trailing: IconButton(
                    onPressed: () => deleteTransaction(id: transaction.id),
                    color: Theme.of(context).errorColor,
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ),
              );
            },
          );
  }
}
