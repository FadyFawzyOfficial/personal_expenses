import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/tracer.dart';
import 'adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String title, double amount, DateTime date)
      addNewTransaction;

  NewTransaction({super.key, required this.addNewTransaction}) {
    trace();
  }

  @override
  // ignore: no_logic_in_create_state
  State<NewTransaction> createState() {
    trace();
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    trace();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    trace();
  }

  @override
  void dispose() {
    super.dispose();
    trace();
  }

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView to prevent the ModalBottomSheet from taking the
    // whole screen hight and causing BOTTOM OVERFLOWED BY *** PIXELS
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    AdaptiveTextButton(
                      label: 'Choose Date',
                      onPressed: pickDate,
                    ),
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

  // Avoid the Error or Exception that will be thrown when the Amount Field is Empty
  void submitTransaction() {
    final inputTitle = titleController.text;
    final inputAmount = double.tryParse(amountController.text);

    if (inputTitle.isEmpty || (inputAmount ?? 0) < 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(inputTitle, inputAmount!, _selectedDate!);

    Navigator.pop(context);
  }
}
