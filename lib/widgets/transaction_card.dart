import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/transaction.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final void Function({required String id}) deleteTransaction;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.deleteTransaction,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    const availableColor = [
      Colors.amber,
      Colors.purple,
      Colors.blue,
      Colors.green,
    ];

    _backgroundColor = availableColor[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: _backgroundColor,
          child: Padding(
            // This makes the Text Container Touch the CircleAvatar Line
            padding: const EdgeInsets.all(16),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        // When we have more width, I want to show a button with a
        // text next to it.
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () =>
                    widget.deleteTransaction(id: widget.transaction.id),
                icon: const Icon(Icons.delete_rounded),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).errorColor,
                ),
              )
            : IconButton(
                onPressed: () =>
                    widget.deleteTransaction(id: widget.transaction.id),
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete_rounded),
              ),
      ),
    );
  }
}
