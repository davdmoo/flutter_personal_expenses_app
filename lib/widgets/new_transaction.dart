import "package:flutter/material.dart";

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
 
  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  void submitTransaction() {
    final inputTitle = titleController.text;
    final inputValue = double.parse(valueController.text);

    if (inputTitle.isEmpty || inputValue <= 0) {
      return;
    }

    widget.addNewTransaction(inputTitle, inputValue);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  onSubmitted: (_) => submitTransaction(),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Value",
                  ),
                  // onChanged: (input) => valueInput = input,
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitTransaction(),
                ),
                FlatButton(
                  child: Text("Add transaction"),
                  textColor: Colors.green,
                  onPressed: submitTransaction,
                )
              ],
            ),
          ),
        );
  }
}