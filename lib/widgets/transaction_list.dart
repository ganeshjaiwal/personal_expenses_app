import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  TransactionsList(this._userTransactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/no-transactions.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      _getTypeIconContainer(_userTransactions[index].type),
                      Expanded(
                        // width:   double.infinity,
                        child: Container(
                          width: 20.0,
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(right: 5.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _userTransactions[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(
                                              height: 1.5,
                                            ),
                                      ),
                                      Text(
                                        DateFormat.yMMMMd("en_US")
                                            .add_jm()
                                            .format(
                                                _userTransactions[index].date),
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(
                                              height: 1.5,
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Text(
                                  "₹${_userTransactions[index].amount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
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

    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: color, width: 2.0),
      ),
      child: Icon(
        icon,
        color: color,
        size: 30.0,
      ),
    );
  }
}
