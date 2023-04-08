import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../utilities/tracer.dart';
import 'new_transaction.dart';
import 'transactions_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
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

  @override
  void initState() {
    super.initState();
    trace();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    trace();
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    trace();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    trace();
    final body = TransactionsBody(
      transactions: _transactions,
      deleteTransaction: _deleteTransaction,
    );

    return AdaptiveTransactionsPage(
      body: body,
      startAddNewTransaction: _startAddNewTransaction,
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

class AdaptiveTransactionsPage extends StatelessWidget {
  final TransactionsBody body;
  final void Function(BuildContext context) startAddNewTransaction;

  const AdaptiveTransactionsPage({
    super.key,
    required this.body,
    required this.startAddNewTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IosPage(
            body: body,
            startAddNewTransaction: startAddNewTransaction,
          )
        : AndroidPage(
            body: body,
            startAddNewTransaction: startAddNewTransaction,
          );
  }
}

class IosPage extends StatelessWidget {
  final TransactionsBody body;
  final void Function(BuildContext context) startAddNewTransaction;

  const IosPage({
    super.key,
    required this.body,
    required this.startAddNewTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Personal Expenses'),
        trailing: GestureDetector(
          onTap: () => startAddNewTransaction(context),
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: body,
    );
  }
}

class AndroidPage extends StatelessWidget {
  final TransactionsBody body;
  final void Function(BuildContext context) startAddNewTransaction;

  const AndroidPage({
    super.key,
    required this.body,
    required this.startAddNewTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          ),
        ],
      ),
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
