import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
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
  // String titleInput;
  // String valueInput;
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
        children: <Widget>[
        Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  // onChanged: (input) => titleInput = input,
                  controller: titleController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Value",
                  ),
                  // onChanged: (input) => valueInput = input,
                  controller: valueController,
                ),
                FlatButton(
                  child: Text("Add transaction"),
                  textColor: Colors.green,
                  onPressed: () {
                    print(valueController.text);
                    print(titleController.text);
                  },
                )
              ],
            ),
          ),
        ),
        Column(
          children: transactions.map((transaction) {
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
                      color: Colors.green,
                      width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "\$ ${transaction.value}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transaction.title,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(transaction.date),
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
          }).toList(),
        ),
      ]),
    );
  }
}
