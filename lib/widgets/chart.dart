import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';

class Chart extends StatefulWidget {
  final recentTransactions;
  Chart(this.recentTransactions);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  String chartType = 'last-7-days';

  List<Map<String, Object>> get groupedTransactionsValues {
    // final resTransct = widget.recentTransactions;
    final resTransct = widget.recentTransactions.where((tx) {
      return checkTransactionForRange(tx);
    }).toList();
    var noOfBars = 0;
    if (chartType == 'last-7-days') {
      noOfBars = 7;
    }
    return List.generate(noOfBars, (index) {
      if (noOfBars == 7) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        var totalSum = 0.0;
        for (var i = 0; i < resTransct.length; i++) {
          if (resTransct[i].date.day == weekDay.day &&
              resTransct[i].date.month == weekDay.month &&
              resTransct[i].date.year == weekDay.year) {
            totalSum += resTransct[i].amount;
          }
        }
        return {
          "day": DateFormat.E().format(weekDay),
          "amount": totalSum,
        };
      }
      return {
        "day": 0,
        "amount": 0,
      };
    }).reversed.toList();
  }

  bool checkTransactionForRange(tx) {
    if (chartType == 'last-7-days') {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    } else if (chartType == 'this-month') {
      final dt = DateTime.now();
      return tx.date.isAfter(DateTime(dt.year, dt.month, 0)) &&
          tx.date.isBefore(DateTime.now());
    } else if (chartType == 'last-month') {
      final dt = DateTime.now();
      return tx.date.isAfter(DateTime(dt.year, dt.month - 1, 0)) &&
          tx.date.isBefore(DateTime(dt.year, dt.month, 1));
    } else if (chartType == 'last-year') {
      final dt = DateTime.now();
      return tx.date.isAfter(DateTime(dt.year - 1, 1, 0)) &&
          tx.date.isBefore(DateTime(dt.year, 1, 1));
    }
    return false;
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, data) {
      return sum + data['amount'];
    });
  }

  Widget _createChart() {
    final dt = DateTime.now();
    print(DateTime(dt.year, 1, 1));
    print(groupedTransactionsValues);
    //groupedTransactionsValues(duration);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionsValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(data['day'], data['amount'],
                (data['amount'] as double) / totalSpending),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: _createChart(),
    );
  }
}
