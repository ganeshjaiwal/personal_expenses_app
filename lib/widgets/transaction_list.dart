import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _actionOnSingleTransaction;

  TransactionsList(this._userTransactions, this._actionOnSingleTransaction);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: ListTile(
              leading: _getTypeIconContainer(_userTransactions[index].type),
              title: Text(
                _userTransactions[index].title,
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 15),
              ),
              subtitle: Text(
                DateFormat.yMMMMd("en_US")
                    .add_jm()
                    .format(_userTransactions[index].date),
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
                        "₹${_userTransactions[index].amount.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 20.0,
                      child:
                          _showOptionsForTransaction(_userTransactions[index]),
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
      },
      itemCount: _userTransactions.length,
    );
  }

  Widget _showOptionsForTransaction(tx) {
    print(tx);
    return PopupMenuButton<int>(
      padding: EdgeInsets.only(right: 10.0),
      onSelected: (val) => _onMenuSelected(val, tx),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          height: 35.0,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.edit,
                  size: 18,
                ),
              ),
              Text(
                "Edit",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          height: 35.0,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.delete_forever,
                  size: 20,
                ),
              ),
              Text(
                "Delete",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onMenuSelected(val, tx) {
    _actionOnSingleTransaction(
      val == 1 ? 'edit' : val == 2 ? 'delete' : '',
      tx.id,
    );
  }

  //Get icon container according to transaction type
  Widget _getTypeIconContainer(type) {
    var icon, color;

    if (type == 'shopping') {
      icon = Icons.shopping_cart;
      color = Colors.greenAccent;
    } else if (type == 'grocery') {
      icon = Icons.shopping_basket;
      color = Colors.greenAccent;
    } else if (type == 'bill-payment') {
      icon = Icons.payment;
      color = Colors.blueAccent;
    } else {
      icon = Icons.monetization_on;
      color = Colors.orangeAccent;
      // Default icon
    }

    return CircleAvatar(
      backgroundColor: Color.fromRGBO(47, 216, 253, 0.1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: color, width: 2.0),
        ),
        padding: EdgeInsets.all(2.5),
        child: Icon(
          icon,
          color: color,
          size: 30.0,
        ),
      ),
    );
  }
}
