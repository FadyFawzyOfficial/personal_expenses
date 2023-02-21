import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String title, double amount, DateTime date)
      addNewTransaction;

  const NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => submitTransaction(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : DateFormat.yMMMd().format(_selectedDate!),
                  ),
                  TextButton(
                    onPressed: pickDate,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitTransaction,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() => _selectedDate = date);
    });
  }

  void submitTransaction() {
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount < 0 || _selectedDate == null) return;

    widget.addNewTransaction(inputTitle, inputAmount, _selectedDate!);

    Navigator.pop(context);
  }
}
