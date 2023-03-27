import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/utilities/tracer.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactions_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 99.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 80.00,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransaction => _transactions
      .where(
        (transaction) => transaction.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    trace();
    final body = SafeArea(
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
              transactions: _transactions,
              deleteTransaction: _deleteTransaction,
            ),
          ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Personal Expenses'),
              trailing: GestureDetector(
                onTap: () => _startAddNewTransaction(context),
                child: const Icon(CupertinoIcons.add_circled),
              ),
            ),
            child: body,
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Personal Expenses'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context),
                ),
              ],
            ),
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // This will allow the ModalBottomSheet to take the full required height
      // which gives more insurance that TextField is not covered by the keyboard.
      isScrollControlled: true,
      builder: (_) => NewTransaction(addNewTransaction: _addNewTransaction),
    );
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: '${DateTime.now()}',
      title: title,
      amount: amount,
      date: date,
    );

    setState(() => _transactions.add(newTransaction));
  }

  void _deleteTransaction({required String id}) => setState(
      () => _transactions.removeWhere((transaction) => transaction.id == id));
}
