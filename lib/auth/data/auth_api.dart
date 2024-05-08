import 'package:split_the_bill/constants/constants.dart';

class AuthAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "api/user";

  Uri getLogin() => _buildUri(
        endpoint: "/login",
      );

  Uri getRegister() => _buildUri(
    endpoint: "",
  );

  Uri getLogout() => _buildUri(
    endpoint: "/logout",
  );

  Uri updateUser(String userId) => _buildUri(
        endpoint: "/$userId",
      );

  Uri _buildUri({
    required String endpoint,
  }) {
    return Uri(
      scheme: "https",
      host: _baseUrl,
      path: "$_apiPath$endpoint",
    );
  }
}
