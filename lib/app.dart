import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:split_the_bill/constants/constants.dart';
import 'package:split_the_bill/router/router.dart';

/// Provider that checks if the backend server is reachable.
final serverStatusProvider = FutureProvider<bool>((ref) async {
  try {
    final response = await http.get(Uri.parse(
        '${Constants.baseScheme}://${Constants.baseApiUrl}:${Constants.basePort}/status'));
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    final goRouter = ref.watch(goRouterProvider);
    final serverStatus = ref.watch(serverStatusProvider);

    return MaterialApp.router(
      title: 'Split the Bill',
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: (context, child) {
        // Add banner above all pages.
        return Scaffold(
          body: Column(
            children: [
              serverStatus.when(
                data: (isOnline) => isOnline
                    ? const SizedBox.shrink()
                    : Container(
                        width: double.infinity,
                        color: Colors.amber,
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Offline - Server currently unreachable',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              // This expands the routed content below the banner
              Expanded(child: child ?? const SizedBox.shrink()),
            ],
          ),
        );
      },
      theme: ThemeData(
        primaryColor: Colors.blue.shade400,
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        tabBarTheme: const TabBarThemeData(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.white,
              width: 4,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade400,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
