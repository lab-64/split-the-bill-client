import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Extension on [AsyncValue] to display a SnackBar with an error message
/// when the value has an error and is not in a loading state.
extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(error.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
