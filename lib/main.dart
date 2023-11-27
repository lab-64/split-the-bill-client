import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/app.dart';
import 'package:split_the_bill/utils/async_error_logger.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        AsyncErrorLogger(),
      ],
      child: const MyApp(),
    ),
  );
}
