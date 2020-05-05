import 'package:flutter/material.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transacrion> transactions = [
    Transacrion(
        id: 't1',
        title: 'New Shoes',
        amount: 3500.00,
        type: 'shopping',
        date: DateTime.now()),
    Transacrion(
        id: 't2',
        title: 'Light bill',
        amount: 560.00,
        type: 'bill-payment',
        date: DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Summary'),
              ),
            ),
            Column(
              children: transactions.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 30.0,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(tx.title),
                          Text(
                            tx.date.toString(),
                          )
                        ],
                      ),
                      Container(
                        child: Text(tx.amount.toString()),
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ));
  }
}
