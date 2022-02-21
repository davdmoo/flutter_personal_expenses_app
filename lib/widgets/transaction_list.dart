import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Center(
      child: Column(children: <Widget>[
        Text("No Transaction Yet", style: Theme.of(context).textTheme.headline6),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover),
        ),
      ],),
    ) : ListView.builder( // for long lists -> better performance
      itemBuilder: (ctx, idx) {
        return Card(
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text("\$ ${transactions[idx].value}"),
                ),
              ),
            ),
            title: Text(
              transactions[idx].title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[idx].date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: (() => deleteTransaction(transactions[idx].id)),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}