import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../utilities/tracer.dart';
import 'transaction_card.dart';
import 'transactions_empty_state.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: transactions.isEmpty
          ? const TransactionsEmptyState()
          : ListView(
              children: transactions
                  .map((transaction) => TransactionCard(
                        key: ValueKey(transaction.id),
                        transaction: transaction,
                        deleteTransaction: deleteTransaction,
                      ))
                  .toList(),
            ),
    );
  }
}
