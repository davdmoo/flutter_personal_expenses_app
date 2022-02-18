import "package:flutter/material.dart";

import "./widgets/new_transaction.dart";
import "./widgets/transaction_list.dart";
import "./models/transaction.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: 'Lato',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "Lato",
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "1",
    //   title: "New Book",
    //   value: 14.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "New Notebook",
    //   value: 14.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "3",
    //   title: "New Phone",
    //   value: 24.99,
    //   date: DateTime.now(),
    // ),
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

  void showInputTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet',
        style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showInputTransaction(context),
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TransactionList(_userTransactions),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showInputTransaction(context),
      ),
    );
  }
}
