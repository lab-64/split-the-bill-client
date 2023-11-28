import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Error logger responsible for tracking AsyncError states set by Riverpod providers within the app.
class AsyncErrorLogger extends ProviderObserver {
  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    debugPrint('Provider ${provider.name} threw $error at $stackTrace');
  }
}
