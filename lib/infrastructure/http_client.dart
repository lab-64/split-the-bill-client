import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/infrastructure/app_exception.dart';

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
      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          return builder(data['data']);
        case 401:
          throw UnauthenticatedException(data['message']);
        case 404:
          throw NotFoundException((data['message']));
        default:
          throw UnknownException((data['message']));
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

@Riverpod(keepAlive: true)
HttpClient httpClient(HttpClientRef ref) {
  return HttpClient(
    client: http.Client(),
  );
}
