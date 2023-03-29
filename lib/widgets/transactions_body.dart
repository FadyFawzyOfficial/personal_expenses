import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../utilities/tracer.dart';
import 'chart.dart';
import 'transactions_list.dart';

class TransactionsBody extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function({required String id}) deleteTransaction;

  const TransactionsBody({
    super.key,
    required this.transactions,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    trace();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Chart(recentTransactions: _recentTransaction),
          ),
          Expanded(
            flex: 7,
            child: TransactionsList(
              transactions: transactions,
              deleteTransaction: deleteTransaction,
            ),
          ),
        ],
      ),
    );
  }

  List<Transaction> get _recentTransaction => transactions
      .where(
        (transaction) => transaction.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ),
      )
      .toList();
}
