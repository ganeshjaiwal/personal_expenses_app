import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key key,
    @required Transaction userTransaction,
    Function getTypeIconContainer,
    Function showOptionsForTransaction,
  })  : _userTransaction = userTransaction,
        _getTypeIconContainer = getTypeIconContainer,
        _showOptionsForTransaction = showOptionsForTransaction,
        super(key: key);

  final Transaction _userTransaction;
  final Function _getTypeIconContainer;
  final Function _showOptionsForTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
          leading: _getTypeIconContainer(_userTransaction.type),
          title: Text(
            _userTransaction.title,
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 15),
          ),
          subtitle: Text(
            DateFormat.yMMMMd("en_US").add_jm().format(_userTransaction.date),
            style: Theme.of(context).textTheme.title.copyWith(
                  height: 1.5,
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
          ),
          trailing: Container(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    "₹${_userTransaction.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 20.0,
                  child: _showOptionsForTransaction(_userTransaction),
                  // IconButton(
                  //   padding: EdgeInsets.only(right: 10),
                  //   icon: Icon(
                  //     Icons.more_vert,
                  //   ),
                  //   onPressed: () => _showOptionsForTransaction(
                  //       _userTransactions[index]),
                  // ),
                ),
              ],
            ),
          )),
    );
  }
}
