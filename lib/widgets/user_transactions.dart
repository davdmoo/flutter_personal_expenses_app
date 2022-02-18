import "package:flutter/material.dart";

import "./transaction_list.dart";
import "./new_transaction.dart";
import "../models/transaction.dart";

class UserTransactions extends StatefulWidget {

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "1",
      title: "New Book",
      value: 14.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "2",
      title: "New Notebook",
      value: 14.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "3",
      title: "New Phone",
      value: 24.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txValue) {
    final newTrans = Transaction(
      title: txTitle,
      value: txValue,
      date: DateTime.now(),
      id: DateTime.now().toString()
    );
    
    setState(() { // setState jalanin build lagi
      _userTransactions.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ]
    );
  }
}