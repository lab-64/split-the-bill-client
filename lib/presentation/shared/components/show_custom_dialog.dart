import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(title),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              content,
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
