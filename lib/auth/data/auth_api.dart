import 'package:split_the_bill/constants/constants.dart';

class AuthAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "api/user";

  Uri getLogin() => _buildUri(
        endpoint: "/login",
      );

  Uri _buildUri({
    required String endpoint,
  }) {
    return Uri(
      scheme: "http",
      port: 8080,
      host: _baseUrl,
      path: "$_apiPath$endpoint",
    );
  }
}
