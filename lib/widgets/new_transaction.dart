import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../widgets/tansaction_type_buttons_list.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  final Function _setTransactionType;

  NewTransaction(this._addTransaction, this._setTransactionType);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final uuid = Uuid();

  void _submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(
        amountController.text.isEmpty ? '0' : amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    var id = uuid.v1();
    var transact = new Transaction(
      id: id,
      title: titleController.text,
      amount: double.parse(amountController.text),
      type: 'grocery',
      date: DateTime.now(),
    );
    widget._addTransaction(transact);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitTransaction(),
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.deepPurple),
              ),
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                _submitTransaction();
              },
            ),
            TransactionTypeButtonsList(widget._setTransactionType),
          ],
        ),
      ),
    );
  }
}
