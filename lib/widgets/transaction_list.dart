import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
        child: transactions.isEmpty ? Center(
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
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "\$ ${transactions[idx].value.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transactions[idx].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        DateFormat.yMMMEd().format(transactions[idx].date),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: transactions.length,
        ),
    );
  }
}