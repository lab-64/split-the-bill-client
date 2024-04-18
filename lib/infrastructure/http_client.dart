import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/infrastructure/app_exception.dart';
import 'package:split_the_bill/infrastructure/session.dart';

part 'http_client.g.dart';

class HttpClient {
  HttpClient({required this.client, required this.session});

  final http.Client client;
  final Session session;

  Future<T> get<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(
        uri,
        headers: session.headers,
      );

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

  Future<T> post<T>({
    required Uri uri,
    required Map<String, dynamic> body,
    required T Function(dynamic data) builder,
    bool isLogin = false,
  }) async {
    try {
      // Merge session headers with additional headers for an HTTP POST request.
      final mergedHeaders = Map<String, String>.from(session.headers);
      mergedHeaders['Content-Type'] = 'application/json';

      final response = await client.post(
        uri,
        body: json.encode(body),
        headers: mergedHeaders,
      );

      if (isLogin) session.updateCookie(response);

      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          return builder(data['data']);
        case 201:
          return builder(data['data']);
        case 401:
          throw UnauthenticatedException(data['message']);
        default:
          throw UnknownException(data['message']);
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  Future<T> put<T>({
    required Uri uri,
    required Map<String, dynamic> body,
    required T Function(dynamic data) builder,
  }) async {
    try {
      // Merge session headers with additional headers for an HTTP POST request.
      final mergedHeaders = Map<String, String>.from(session.headers);
      mergedHeaders['Content-Type'] = 'application/json';

      final response = await client.put(
        uri,
        body: json.encode(body),
        headers: mergedHeaders,
      );

      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          return builder(data['data']);
        case 201:
          return builder(data['data']);
        case 401:
          throw UnauthenticatedException(data['message']);
        default:
          throw UnknownException(data['message']);
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  Future<void> delete<T>({
    required Uri uri,
  }) async {
    try {
      // Merge session headers with additional headers for an HTTP POST request.
      final mergedHeaders = Map<String, String>.from(session.headers);
      mergedHeaders['Content-Type'] = 'application/json';

      final response = await client.delete(
        uri,
        headers: mergedHeaders,
      );

      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          return;
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
    session: ref.read(sessionProvider),
  );
}
