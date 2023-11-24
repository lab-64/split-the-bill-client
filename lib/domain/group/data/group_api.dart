import 'package:split_the_bill/constants/constants.dart';

class GroupAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "/api/group";

  Uri getGroup(String groupId) => _buildUri(
        endpoint: "/$groupId",
      );

  Uri getGroups() => _buildUri(
        endpoint: "",
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
