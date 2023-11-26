// TODO: Replace snackbar with alert dialog

import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
    );

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented',
    );

Future<void> showExceptionSnackbar({
  required BuildContext context,
  required dynamic exception,
}) async {
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(exception.toString()),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
