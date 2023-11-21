import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_client.g.dart';

class HttpClient {
  HttpClient({required this.client});
  final http.Client client;

  Future<T> get<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          return Future.error("unauthorized");
        //throw InvalidApiKeyException();
        case 404:
          return Future.error("not found");

        //throw CityNotFoundException();
        default:
          return Future.error("unknown");
        //throw UnknownException();
      }
    } on SocketException catch (_) {
      return Future.error(_);
      //throw NoInternetConnectionException();
    }
  }
}

@Riverpod(keepAlive: true)
HttpClient httpClient(HttpClientRef ref) {
  return HttpClient(
    client: http.Client(),
  );
}
