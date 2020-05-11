import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentAmountPer;

  ChartBar(this.label, this.spentAmount, this.spentAmountPer);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text('₹${spentAmount.toStringAsFixed(0)}'),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spentAmountPer,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
