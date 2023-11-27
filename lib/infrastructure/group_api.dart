import 'package:split_the_bill/constants/constants.dart';

class GroupAPI {
  static const String _baseUrl = Constants.baseApiUrl;
  static const String _apiPath = "api/user";

  Uri getGroups() => _buildUri(
        endpoint: "",
        //parametersBuilder: () => cityQueryParameters(city),
      );

  Uri _buildUri({
    required String endpoint,
    //required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "http",
      port: 8080,
      host: _baseUrl,
      path: "$_apiPath$endpoint",
      //queryParameters: parametersBuilder(),
    );
  }

  /*
  Map<String, dynamic> cityQueryParameters(String city) => {
        "q": city,
        "appid": apiKey,
        "units": "metric",
      };
   */
}
