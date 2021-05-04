import 'package:flutter/material.dart';

class DefFnReturn {
  bool success = false;
  String message = "";

  bool get getSuccess => this.success;
  set setSuccess(bool success) => this.success = success;

  String get getMessage => this.message;
  set setMessage(String message) => this.message = message;
}

void msgBox({String title, String message, BuildContext boxContext}) {
  showDialog(
      context: boxContext,
      builder: (BuildContext boxContext) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Entendi'),
              onPressed: () {
                Navigator.of(boxContext).pop();
              },
            ),
          ],
        );
      });
}
