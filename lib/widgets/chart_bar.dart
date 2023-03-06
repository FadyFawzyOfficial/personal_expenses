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
        Expanded(
          child: Container(
            width: 10,
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
        ),
        SizedBox(
          // Now the text here at the bottom will always have a height of 24.
          // No matter how much height it needs and therefore the text is now aligned,
          // the bars are aligned and the text at the top is also aligned.
          // And that of course looks better than bars jumping randomly around.
          height: 24,
          child: FittedBox(
            child: Text('\$${dayExpenses.toStringAsFixed(0)}'),
          ),
        ),
      ],
    );
  }
}
