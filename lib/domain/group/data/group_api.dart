import 'package:split_the_bill/constants/constants.dart';

class GroupAPI {
  static const String _apiPath = "/api/group";

  Uri createGroup() => _buildUri(
        endpoint: "/",
      );

  Uri editGroup(String groupId) => _buildUri(
        endpoint: "/$groupId",
      );

  Uri getGroup(String groupId) => _buildUri(
        endpoint: "/$groupId",
      );

  Uri getGroupsByUser(String userId) => _buildUri(
        endpoint: "",
        parametersBuilder: () => {"userId": userId},
      );

  Uri deleteGroup(String groupId) => _buildUri(
        endpoint: "/$groupId",
      );

  Uri _buildUri({
    required String endpoint,
    Map<String, dynamic> Function()? parametersBuilder,
  }) {
    return Uri(
      scheme: Constants.baseScheme,
      port: Constants.basePort,
      host: Constants.baseApiUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder?.call(),
    );
  }

  static String buildInvitationSuffix(String groupId) {
    return '$_apiPath/invitation/$groupId/accept';
  }
}
