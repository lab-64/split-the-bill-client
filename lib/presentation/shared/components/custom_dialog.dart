import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, Widget body) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text('Check Items')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              body,
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
