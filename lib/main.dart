import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(110, 106, 252, 1),
        accentColor: Color.fromRGBO(47, 216, 253, 1),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _transactionType = 'shopping';
  final List<Transaction> transactions = [
    // Transaction(
    //     id: 't1',
    //     title: 'New Shoes',
    //     amount: 3500.00,
    //     type: 'shopping',
    //     date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Light bill',
    //     amount: 560.00,
    //     type: 'bill-payment',
    //     date: DateTime.now())
  ];

  void addNewTransaction(Transaction transaction) {
    setState(() {
      transaction.type = _transactionType;
      transactions.add(transaction);
    });
  }

  void setTransactionType(String type) {
    _transactionType = type;
  }

  void _showAddTransactionModal(BuildContext cxt) {
    showModalBottomSheet(
      context: cxt,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction, setTransactionType),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddTransactionModal(context),
          )
        ],
      ),
      body: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 250,
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Image.asset(
                      'assets/images/no-transactions.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 60.0),
                    child: Text(
                      'No transactions added yet!',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.blueGrey),
                    ),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Chart(transactions),
                  ),
                  TransactionsList(transactions),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransactionModal(context),
      ),
    );
  }
}
