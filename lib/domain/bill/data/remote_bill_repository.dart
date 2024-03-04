import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_api.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

class RemoteBillRepository extends BillRepository {
  RemoteBillRepository({required this.api, required this.client});

  final BillAPI api;
  final HttpClient client;

  @override
  Future<Bill> edit(Bill bill) => client.put(
        uri: api.updateBill(bill.id),
        body: bill.toMap(),
        builder: (data) => Bill.fromMap(data),
      );

  @override
  Future<Bill> getBill(String billId) => client.get(
        uri: api.getBill(billId),
        builder: (data) => Bill.fromMap(data),
      );

  @override
  Future<List<Bill>> getBillsByUser(String userId) {
    // TODO: implement getBillsByUser (endpoint in backend missing right now)
    return Future.value([]);
  }

  @override
  Future<Bill> create(Bill bill) => client.post(
        uri: api.createBill(),
        body: bill.toMap(),
        builder: (data) => Bill.fromMap(data),
      );
}
