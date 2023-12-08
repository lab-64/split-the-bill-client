import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

/// This class maintains the session headers. It updates them based on the 'set-cookie' header from an HTTP response.
/// Extracts the 'session_cookie' value from the 'set-cookie' header and sets it
/// in the session headers under the 'cookie' key.
class Session {
  final Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      final match = RegExp(r'session_cookie=([^;]+)').firstMatch(rawCookie);
      final String? sessionCookie = match?.group(0);

      if (sessionCookie != null) {
        _headers['cookie'] = sessionCookie;
      }
    }
  }
}

@Riverpod(keepAlive: true)
Session session(SessionRef ref) {
  return Session();
}
