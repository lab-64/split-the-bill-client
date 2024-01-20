import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/routes.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Split the Bill',
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: ThemeData(
        primaryColor: Colors.blue.shade400,
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEFEFEF),
        ),
      ),
    );
  }
}
