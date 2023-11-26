import 'package:split_the_bill/constants/constants.dart';

class GroupAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "/api/group";

  Uri createGroup() => _buildUri(
        endpoint: "/",
      );

  Uri getGroup(String groupId) => _buildUri(
        endpoint: "/$groupId",
      );

  Uri getGroupsByUser(String userId) => _buildUri(
        endpoint: "",
        parametersBuilder: () => {"userId": userId},
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
