import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "./widgets/new_transaction.dart";
import "./widgets/transaction_list.dart";
import "./widgets/chart.dart";
import "./models/transaction.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]); // for landscape mode only

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        // errorColor: Colors.red, // errorColor by default is red
        fontFamily: 'Lato',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white,
          )
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

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewTransaction(String txTitle, double txValue, DateTime txDate) {
    final newTrans = Transaction(
      title: txTitle,
      value: txValue,
      date: txDate,
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
    final appBar = AppBar(
      title: Text('Wallet',
      style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => showInputTransaction(context),
        )
      ]
    );
    
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
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
