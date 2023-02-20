import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get weeklyTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalDayExpenses = 0.0;

      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalDayExpenses += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'amount': totalDayExpenses,
      };
    });
  }

  double get weekExpenses {
    return weeklyTransactions.fold(
      0,
      (previousValue, transaction) =>
          previousValue + (transaction['amount'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: weeklyTransactions
              .map(
                (transaction) => ChartBar(
                  label: transaction['day'] as String,
                  dayExpenses: transaction['amount'] as double,
                  weekExpenses: weekExpenses,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
