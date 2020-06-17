import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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
              button: TextStyle(
                color: Colors.white,
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
  final List<Transaction> transactions = [];
  bool _showChart = false;

  void addNewTransaction(Transaction transaction) {
    setState(() {
      transaction.type = _transactionType;
      transactions.add(transaction);
    });
  }

  void updateTransaction(Transaction transaction) {
    final index = transactions.indexWhere((tx) {
      return tx.id == transaction.id;
    });
    transaction.type = _transactionType;
    setState(() {
      transactions.replaceRange(index, index + 1, [transaction]);
    });
  }

  void setTransactionType(String type) {
    _transactionType = type;
  }

  void _showAddTransactionModal(BuildContext cxt, Transaction tx) {
    if (tx == null) {
      tx = new Transaction(id: null, title: null, amount: null, date: null);
    }
    _transactionType = 'shopping';
    showModalBottomSheet(
      context: cxt,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addNewTransaction,
            setTransactionType,
            updateTransaction,
            tx,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void actionOnSingleTransaction(String type, String id) {
    if (type == 'edit') {
      _editTransaction(id);
    } else if (type == 'delete') {
      _deleteSingleTransaction(id);
    }
  }

  void _editTransaction(String id) {
    final tx =
        transactions[transactions.indexWhere((transact) => transact.id == id)];
    _showAddTransactionModal(context, tx);
  }

  void _deleteSingleTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeModeWidget(
    chartWidget,
    txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('List', style: Theme.of(context).textTheme.subhead),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            activeTrackColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
          Text(
            'Chart',
            style: Theme.of(context).textTheme.subhead,
          ),
        ],
      ),
      _showChart ? chartWidget : txListWidget
    ];
  }

  List<Widget> _buildPortraitModeWidget(
    chartWidget,
    txListWidget,
  ) {
    return [chartWidget, txListWidget];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showAddTransactionModal(context, null),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _showAddTransactionModal(context, null),
              )
            ],
          );
    final chartWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (isLandscape ? 0.7 : 0.3),
      width: double.infinity,
      child: Chart(transactions),
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(transactions, actionOnSingleTransaction),
    );
    final pageBody = transactions.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Image.asset(
                    'assets/images/no-transactions.png',
                    fit: BoxFit.none,
                  ),
                ),
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
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
        : SafeArea(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                if (isLandscape)
                  ..._buildLandscapeModeWidget(
                    chartWidget,
                    txListWidget,
                  ),
                if (!isLandscape)
                  ..._buildPortraitModeWidget(
                    chartWidget,
                    txListWidget,
                  ),
              ]),
            ),
          );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddTransactionModal(context, null),
                  ),
          );
  }
}
