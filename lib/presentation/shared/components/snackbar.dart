import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void showNotImplementedSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Not implemented yet'),
    ),
  );
}

void showSuccessSnackBar(
  BuildContext context,
  AsyncValue<void> state,
  String text, {
  void Function()? goTo,
}) {
  if (!state.isLoading && !state.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(text),
      ),
    );

    if (goTo != null) {
      goTo();
    } else {
      GoRouter.of(context).pop();
    }
  }
}

void showErrorSnackBar(
  BuildContext context,
  AsyncValue<void> state,
  String text,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
    ),
  );
}
