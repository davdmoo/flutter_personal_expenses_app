import "package:flutter/material.dart";
import "package:intl/intl.dart";

import './adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
 
  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransaction() {
    if (_valueController.text.isEmpty) return;

    final inputTitle = _titleController.text;
    final inputValue = double.parse(_valueController.text);

    if (inputTitle.isEmpty || inputValue <= 0 || _selectedDate == null) return;

    widget.addNewTransaction(inputTitle, inputValue, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, // context di kanan = class property context
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    )
      .then((pickedDate) {
        if (pickedDate == null) return;

        setState(() {
          _selectedDate = pickedDate;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    // onChanged: (input) => titleInput = input,
                    controller: _titleController,
                    onSubmitted: (_) => _submitTransaction(),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Value",
                    ),
                    // onChanged: (input) => valueInput = input,
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitTransaction(),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null ? "No Date Chosen!" : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: AdaptiveFlatButton(_presentDatePicker, "Choose Date"),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Add transaction"),
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submitTransaction,
                  )
                ],
              ),
            ),
          ),
    );
  }
}