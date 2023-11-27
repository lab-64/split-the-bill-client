// TODO: Replace snackbar with alert dialog

import 'package:flutter/material.dart';

Future<void> showExceptionSnackBar({
  required BuildContext context,
  required dynamic exception,
}) async {
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(exception.toString()),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
