import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/infrastructure/app_exception.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

part 'http_client.g.dart';

class HttpClient {
  HttpClient({
    required this.client,
    required this.sharedUtility,
  });

  final http.Client client;
  final SharedUtility sharedUtility;

  Future<T> get<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(
        uri,
        headers: {
          'cookie': sharedUtility.getAuthCookie(),
        },
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
      final mergedHeaders = {
        'cookie': sharedUtility.getAuthCookie(),
      };
      mergedHeaders['Content-Type'] = 'application/json';

      final response = await client.post(
        uri,
        body: json.encode(body),
        headers: mergedHeaders,
      );

      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          if (isLogin) {
            data['data']['sessionCookie'] = _extractSessionCookie(response);
            return builder(data['data']);
          }

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
      final mergedHeaders = {
        'cookie': sharedUtility.getAuthCookie(),
      };
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

  Future<T> putMultipart<T>({
    required Uri uri,
    required Map<String, String> body,
    required XFile? file,
    required T Function(dynamic data) builder,
  }) async {
    try {
      // Merge session headers with additional headers for an HTTP POST request.
      final mergedHeaders = {
        'cookie': sharedUtility.getAuthCookie(),
      };
      mergedHeaders['Content-Type'] = 'multipart/form-data';

      final request = http.MultipartRequest('PUT', uri);
      request.headers.addAll(mergedHeaders);
      request.fields.addAll(body);

      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', file.path),
        );
      }

      final response = await request.send();
      final data = jsonDecode(await response.stream.bytesToString());

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
      final response = await client.delete(
        uri,
        headers: {
          'cookie': sharedUtility.getAuthCookie(),
        },
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

  String _extractSessionCookie(http.Response response) {
    // extract cookie with error handling
    final rawCookie = response.headers['set-cookie'];
    if (rawCookie == null) {
      throw Exception('No cookie in response');
    }

    final match = RegExp(r'session_cookie=([^;]+)').firstMatch(rawCookie);
    if (match == null) {
      throw Exception('No session_cookie in response');
    }

    return match.group(0)!;
  }
}

@Riverpod(keepAlive: true)
HttpClient httpClient(HttpClientRef ref) {
  return HttpClient(
    client: http.Client(),
    sharedUtility: ref.read(sharedUtilityProvider),
  );
}
