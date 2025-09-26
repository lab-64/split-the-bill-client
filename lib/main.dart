import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_the_bill/app.dart';
import 'package:split_the_bill/infrastructure/async_error_logger.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:split_the_bill/constants/constants.dart';


/// Check if the server is reachable by making a GET request to the /status endpoint.
/// Returns true if the server responds with a 200 status code, false otherwise.
Future<bool> isServerReachable() async {
  try {
    final response = await http.get(Uri.parse('${Constants.baseScheme}://${Constants.baseApiUrl}:${Constants.basePort}/status'));
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      observers: [
        AsyncErrorLogger(),
      ],
      // Server Status Banner
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FutureBuilder<bool>(
            future: isServerReachable(),
            builder: (context, snapshot) {
              final showBanner = snapshot.hasData && !snapshot.data!;
              return Column(
                children: [
                  if (showBanner)
                    Container(
                      width: double.infinity,
                      color: Colors.amber,
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        'Offline - Server currently unreachable',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  // Main App Widget
                  const Expanded(child: MyApp()),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}
