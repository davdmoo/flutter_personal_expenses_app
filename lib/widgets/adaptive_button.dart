import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class AdaptiveFlatButton extends StatelessWidget {
  final Function actionHandler;
  final String text;

  AdaptiveFlatButton(this.actionHandler, this.text);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
      ? CupertinoButton(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: actionHandler,
      )
      : FlatButton(
        textColor: Theme.of(context).primaryColor,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: actionHandler,
      );
  }
}