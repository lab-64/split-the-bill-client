import 'package:split_the_bill/constants/constants.dart';

class UserAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "/api/user";

  Uri updateUser(String userId) => _buildUri(
        endpoint: "/$userId",
      );

  Uri _buildUri({
    required String endpoint,
    Map<String, dynamic> Function()? parametersBuilder,
  }) {
    return Uri(
      scheme: "http",
      port: 8080,
      host: _baseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder?.call(),
    );
  }
}
