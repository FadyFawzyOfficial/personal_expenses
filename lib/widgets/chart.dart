import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get weeklyTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalDayExpenses = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        final currentTransactionDate = recentTransactions[i].date;

        if (currentTransactionDate.day == weekDay.day &&
            currentTransactionDate.month == weekDay.month &&
            currentTransactionDate.year == weekDay.year) {
          totalDayExpenses += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E(weekDay));
      print(totalDayExpenses);

      return {'day': DateFormat.E(weekDay), 'amount': totalDayExpenses};
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 6,
      margin: EdgeInsets.all(16),
    );
  }
}
