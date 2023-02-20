import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double dayExpenses;
  final double weekExpenses;

  const ChartBar({
    super.key,
    required this.label,
    required this.dayExpenses,
    required this.weekExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Container(
          width: 10,
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              FractionallySizedBox(
                heightFactor:
                    weekExpenses == 0 ? 0 : dayExpenses / weekExpenses,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
        Text('\$${dayExpenses.toStringAsFixed(0)}')
      ],
    );
  }
}
