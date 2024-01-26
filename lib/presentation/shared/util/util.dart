import 'package:flutter/material.dart';

void showNotImplementedSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Not implemented yet'),
    ),
  );
}
