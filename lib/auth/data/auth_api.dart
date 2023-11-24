import 'package:split_the_bill/constants/constants.dart';

class AuthAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "/user";

  Uri getUser(String id) => _buildUri(
        endpoint: "/$id",
        parametersBuilder: () => getUserParameters(id),
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "http",
      port: 8080,
      host: _baseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> getUserParameters(String id) => {
        "id": id,
      };
}
