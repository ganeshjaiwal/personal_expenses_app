import 'package:flutter/material.dart';

class TransactionTypeButtonsList extends StatefulWidget {
  final Function _setTransactionType;

  TransactionTypeButtonsList(this._setTransactionType);
  @override
  _TransactionTypeButtonsListState createState() =>
      _TransactionTypeButtonsListState();
}

class _TransactionTypeButtonsListState
    extends State<TransactionTypeButtonsList> {
  var _radioValue1 = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 1,
          groupValue: _radioValue1,
          onChanged: _handleRadioValueChange1,
        ),
        new Text(
          'Shopping',
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: 2,
          groupValue: _radioValue1,
          onChanged: _handleRadioValueChange1,
        ),
        new Text(
          'Grocery',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
        new Radio(
          value: 3,
          groupValue: _radioValue1,
          onChanged: _handleRadioValueChange1,
        ),
        new Text(
          'Bill Payment',
          style: new TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  _handleRadioValueChange1(val) {
    print(val);
    setState(() {
      _radioValue1 = val;
    });
    var type = val == 1
        ? 'shopping'
        : val == 2 ? 'grocery' : val == 3 ? 'bill-payment' : '';
    widget._setTransactionType(type);
  }
}
