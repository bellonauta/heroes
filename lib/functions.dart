import 'package:flutter/material.dart';

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
