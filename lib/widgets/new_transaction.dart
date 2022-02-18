import "package:flutter/material.dart";

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final Function addNewTransaction;
 
  NewTransaction(this.addNewTransaction);

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
                    addNewTransaction(titleController.text, double.parse(valueController.text));
                  },
                )
              ],
            ),
          ),
        );
  }
}