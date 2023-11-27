import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/shared/alert_snackbar.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(BuildContext context) {
    if (!isLoading && hasError) {
      showExceptionSnackBar(
        context: context,
        exception: error,
      );
    }
  }
}
