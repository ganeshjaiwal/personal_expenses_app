import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../widgets/tansaction_type_buttons_list.dart';
import '../models/transaction.dart';
import '../widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  final Function _setTransactionType;
  final Function _updateTransaction;
  final Transaction tx;

  NewTransaction(
    this._addTransaction,
    this._setTransactionType,
    this._updateTransaction,
    this.tx,
  );

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final uuid = Uuid();

  @override
  initState() {
    super.initState();
    if (widget.tx.id != null) {
      _amountController.text = widget.tx.amount.toStringAsFixed(2);
      _selectedDate = widget.tx.date;
      _titleController.text = widget.tx.title;
    }
  }

  void _submitTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(
        _amountController.text.isEmpty ? '0' : _amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    if (widget.tx.id != null) {
      var transact = new Transaction(
        id: widget.tx.id,
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        type: widget.tx.type,
        date: _selectedDate,
      );
      widget._updateTransaction(transact);
      Navigator.of(context).pop();
    } else {
      var id = uuid.v1();
      var transact = new Transaction(
        id: id,
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        type: 'grocery',
        date: _selectedDate,
      );
      widget._addTransaction(transact);
      Navigator.of(context).pop();
    }
  }

  void _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((date) {
      print(date);
      if (date == null) {
        return;
      }
      showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: _selectedDate.hour,
          minute: _selectedDate.minute,
        ),
      ).then((time) {
        print(time);
        if (time == null) {
          return;
        }
        setState(() {
          _selectedDate = new DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            right: 15.0,
            left: 15.0,
            top: 15.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTransaction(),
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: <Widget>[
                  Text(DateFormat.yMMMMd("en_US")
                      .add_jm()
                      .format(_selectedDate)),
                  AdaptiveFlatButton(_chooseDate, 'Choose Date')
                ],
              ),
              TransactionTypeButtonsList(widget._setTransactionType, widget.tx),
              SizedBox(
                height: 12.0,
              ),
              RaisedButton(
                child: widget.tx.id != null
                    ? Text(
                        'Update',
                      )
                    : Text(
                        'Add Transaction',
                      ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  _submitTransaction();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
