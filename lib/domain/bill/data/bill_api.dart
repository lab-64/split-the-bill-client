import 'package:split_the_bill/constants/constants.dart';

class BillAPI {
  static const String _apiPath = "/api/bill";

  Uri createBill() => _buildUri(
        endpoint: "/",
      );

  Uri getBill(String billId) => _buildUri(
        endpoint: "/$billId",
      );

  Uri updateBill(String billId) => _buildUri(
        endpoint: "/$billId",
      );

  Uri deleteBill(String billId) => _buildUri(
        endpoint: "/$billId",
      );

  Uri getBillByUser(String userId, bool isUnseen, bool isOwner) => _buildUri(
        endpoint: "/",
        parametersBuilder: () => {
          "userId": userId,
          "isUnseen": isUnseen.toString(),
          "isOwner": isOwner.toString()
        },
      );

  Uri editItem(String itemId) => _buildUri(
        endpoint: "/item/$itemId",
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
}
