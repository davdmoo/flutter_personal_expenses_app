import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
// import "package:flutter/services.dart";

import "./widgets/new_transaction.dart";
import "./widgets/transaction_list.dart";
import "./widgets/chart.dart";
import "./models/transaction.dart";

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]); // for landscape mode only

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
  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS 
    ? CupertinoNavigationBar(
      middle: Text("Wallet"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        GestureDetector(
          child: Icon(CupertinoIcons.add),
          onTap: () => showInputTransaction(context),
        )
      ],
      ),
    )
    : AppBar(
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
    final transactionListWidget = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Show Chart",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
            if (!isLandscape) Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
              child: Chart(_recentTransactions),
            ),
            if (!isLandscape) transactionListWidget,
            if (isLandscape) _showChart
            ? Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
              child: Chart(_recentTransactions),
            )
            : transactionListWidget
          ]),
        ),
      );
    
    return Platform.isIOS
    ? CupertinoPageScaffold(
        child: pageBody,
        navigationBar: appBar,
      )
    : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
      ? Text("ADDDDDD")
      : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showInputTransaction(context),
      ),
    );
  }
}
