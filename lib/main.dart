import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/app.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        MyObserver(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyObserver extends ProviderObserver {
  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    print('Provider ${provider.name} threw $error at $stackTrace');
  }
}
