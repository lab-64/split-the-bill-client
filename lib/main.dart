import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_the_bill/app.dart';
import 'package:split_the_bill/infrastructure/async_error_logger.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      observers: [
        AsyncErrorLogger(),
      ],
      child: const MyApp(),
    ),
  );
}
