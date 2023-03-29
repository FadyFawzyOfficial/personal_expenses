import 'package:flutter/material.dart';

class TransactionsEmptyState extends StatelessWidget {
  const TransactionsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No transactions add yet!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Expanded(
          child: Image(
            image: AssetImage('assets/images/waiting.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
